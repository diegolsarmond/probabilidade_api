// ignore_for_file: avoid_print

import 'constants/_constants.dart';
import 'entities/_entities.dart';
import 'enums/_enums.dart';
import 'extensions/_extensions.dart';
import 'i18n/_i18n.dart';
import 'models/_models.dart';

enum DualLogicType {
  alternation,
  repeat;

  String get nameTr {
    switch (this) {
      case DualLogicType.alternation:
        return R.strings.logicsTranslate.alternation;
      case DualLogicType.repeat:
        return R.strings.logicsTranslate.repeat;
    }
  }
}

class DualProbUseCase {
  late final List<String> _history;
  final String key1;
  final String key2;
  final String zero = AppConstants.zero;
  final int limit;
  final int minProbability;

  DualProbUseCase({
    required List<String> history,
    required this.key1,
    required this.key2,
    required this.limit,
    required this.minProbability,
  }) {
    _history = history.reversed
        .toList()
        .sublist(
          0,
          history.length < limit ? history.length : limit,
        )
        .toList();
    _history.removeWhere((e) => e == AppConstants.zero);
  }

  // Aplica a Regra de Alternância em toda a sequência
  Map<String, dynamic> _applyAlternation() {
    String? nextKey;

    // Quantas vezes alternou para K1 ou K2
    int alternationCount = 0; // Cores que fazem parte das alternâncias
    int consecutiveCount = 1; // Contador de cores consecutivas
    List<int> consecutiveHistory = []; // Historico de alternacoes consecutivas
    bool lastHasAlternation = false; // Flag para verificar se estamos alternando
    int repeat = 0;

    /////////////////////// ATÉ AQUI CALCULA A PORCENTAGEM DO HISTORICO ///////////////////////////////////////
    // Percorrer o histórico a partir do segundo item
    if (_history.last == _history[_history.length - 2]) repeat++;
    for (int i = _history.length - 1; i > 1; i--) {
      // Verificar se a cor atual é diferente da anterior (alternância)
      if (_history[i] != _history[i - 1] && _history[i] == _history[i - 2]) {
        // Se está alternando, incrementar o contador
        if (!lastHasAlternation) {
          lastHasAlternation = true;
          consecutiveCount = 3; // Inicializa a contagem com as duas primeiras cores alternadas
        } else {
          consecutiveCount++; // Incrementa a alternância
        }
      } else {
        repeat++;
        // Se encontrar uma sequência de cores iguais, finalize a alternância
        if (lastHasAlternation) {
          alternationCount += consecutiveCount; // Soma a $antidade de cores da alternância
          consecutiveHistory.add(consecutiveCount); // Add na lista de saídas para calculo de média
          lastHasAlternation = false;
          consecutiveCount = 1; // Reseta o contador para a próxima alternância
        }
      }
    }

    // Caso o histórico termine com uma alternância, precisamos verificar isso
    if (lastHasAlternation) {
      alternationCount += consecutiveCount; // Soma a última alternância
      consecutiveHistory.add(consecutiveCount); // Adiciona a sequencia da jogada atual no historico
    } else {
      repeat++;
    }

    // Vai calcular a porcentagem de presença de alternancia em tod o historico
    double historyAnalysisPercentage = alternationCount / (alternationCount + repeat) * 100;
    /////////////////////////////////////// FIM /////////////////////////////////////////////

    /////////////////////// ATÉ AQUI CALCULA A PORCENTAGEM DO HISTORICO ///////////////////////////////////////

    int median = 0;
    if (historyAnalysisPercentage > minProbability) {
      // Se houver mais de 50% de Alternancia entao ele busca a media
      var medianList = [...consecutiveHistory]..removeLast(); // historico de jogas anteriores
      median = medianList.medianFloor();
      var lastConsecutiveCount = consecutiveHistory.last;
      var lastThree = _history.sublist(0, 3); // Pega as 3 ultimas jogadas
      if (lastThree[0] != _history[1] && lastThree[0] == lastThree[2]) {
        // Verifica as 3 ultimas jogadas compoe uma alternancia
        // se SIM
        if (lastThree.last == key1) nextKey = key2; //Se o ultimo for K1 ele indica K2
        if (lastThree.last == key2) nextKey = key1; //Se o ultimo for K2 ele indica k1

        /////////////////////////////////////// FIM /////////////////////////////////////////////
        // if (lastConsecutiveCount >= median) nextKey = null;
        nextKey = null;
        ///////////// FIM ////////////////////
      }
    }

    ///////////////////////// ATÉ AQUI ELE CONSIDERA AS ÚLTIMAS 3 JOGADAS ////////////////////////////////

    return {
      'nextKey': nextKey,
      'median': median,
      'frequency': historyAnalysisPercentage.round(),
      'distinctNumbers': 2,
    };
  }

  Map<String, dynamic> _applyRepetition() {
    ////////////////////// AQUI CALCULA A PORCENTAGEM DE REPETIÇÃO /////////////////
    var alternationMap = _applyAlternation(); // Aplica a regra de alternancia
    var alternationPercent = alternationMap['frequency'] as int; // Busca o resultado de alternancia

    // Recupera a porcentagem de repetição atráves da alternancia
    var repetitionPercent = 100 - alternationPercent;

    int median = 0; // Aqui ficara armazenado a media das repeticoes
    String? nextKey; // Aqui ficara armazenado a sugestao da proxima key

    /////////////////////////////////////// FIM ////////////////////////////////////////

    ///////////////// AQUI CALCULA A MEDIA DE REPETICOES DA PROXIMA SUGESTAO /////////////////

    if (repetitionPercent > minProbability) {
      // Armazena o historico de Repetições
      Map<String, List<int>> repeatCountList = {key1: [], key2: []};
      var lastHasRepeat = false; // armazena se possui repeticoes nas ultimas jogadas
      var count = 0; // Conta as repeticoes
      for (int i = _history.length - 1; i > 0; i--) {
        if (_history[i] == _history[i - 1]) {
          // Verifica se os valores sao iguais
          count++;
          lastHasRepeat = true;
        } else {
          if (count != 0) {
            lastHasRepeat = false;
            count++;
            if (_history[i] == key1 && count > 2) repeatCountList[key1]!.add(count);
            if (_history[i] == key2 && count > 2) repeatCountList[key2]!.add(count);
          }
          count = 0;
        }
      }

      /////////////////////////////////////// FIM ////////////////////////////////////////

      ////////////AQUI CALCULA A QUANTIDADE DE REPETICOES DA ULTIMA JOGADA /////////////////

      // Se houver repeticoes nas ultimas jogadas, entao ele ira conta-las
      count++;
      var lastThree = _history.sublist(0, 3);
      if (lastThree[0] == lastThree[1] && lastThree[1] == lastThree[2]) {
        var listCount = repeatCountList[lastThree.first];
        median = listCount!.medianFloor();

        // Depois de contar as repeticoes da ultima jogada, ira comparar com o valor medio
        // ira atribuir a sugestao, se abaixo da media

        /////////////////////////////////////// FIM /////////////////////////////////////////////
        if (lastHasRepeat && count < median) nextKey = lastThree.last;
        /////////////////////////////////////// FIM /////////////////////////////////////////////
      }
    }
    return {
      'nextKey': nextKey,
      'median': median,
      'frequency': repetitionPercent,
      'distinctNumbers': 2,
    };
  }

  // Função principal para analisar os números e calcular as probabilidades
  DualProbResultEntity analyze(ModelProbType modelProbType) {
    var alternationMap = _applyAlternation();
    var alternation = DualProbResult.fromMap(
      map: alternationMap,
      key1: key1,
      key2: key2,
      logicType: DualLogicType.alternation,
    );

    var repetitionMap = _applyRepetition();
    var repeat = DualProbResult.fromMap(
      map: repetitionMap,
      key1: key1,
      key2: key2,
      logicType: DualLogicType.repeat,
    );

    print(
        '============================ ${modelProbType.name} =====================================');
    print(
      'ALTERNANCIA(${alternation.frequencyPercent}%)'
      ' => MÉDIA => ${alternation.median}'
      ' => SUGESTAO => ${alternation.nextKey}',
    );
    print(
      'REPETIÇÃO(${repeat.frequencyPercent}%)'
      ' => MÉDIA => ${repeat.median}'
      ' => SUGESTAO => ${repeat.nextKey}',
    );
    print('=================================================================');
    return DualProbResultModel(
      alternation: alternation,
      repeat: repeat,
      modelProbType: modelProbType,
      minProbability: minProbability,
    ); // Retorna as probabilidades e os pesos
  }
}
