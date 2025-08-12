
import 'constants/_constants.dart';
import 'entities/_entities.dart';
import 'enums/_enums.dart';
import 'extensions/_extensions.dart';
import 'models/_models.dart';

class SectorProbUseCase {
  late final List<String> _history;
  final String key1;
  final String key2;
  final String key3;
  final String zero = AppConstants.zero;
  final int limit;
  final int minProbability;

  SectorProbUseCase({
    required List<String> history,
    required this.key1,
    required this.key2,
    required this.key3,
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
    final List<int> alternationHistory = [];
    final List<int> noCountHistory = [];

    int okCount = 0;
    int noCount = 0;
    int lastNoCount = 0;
    for (int i = _history.length - 1; i >= 3; i--) {
      if (_history[i] != _history[i - 1] && _history[i] == _history[i - 2]) {
        if (okCount == 0) lastNoCount = noCount;
        if (_history[i - 1] == _history[i - 3]) {
          okCount++;
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
        } else {
          noCount++;
          if (okCount > 0) {
            alternationHistory.add(okCount);
            noCount--;
          }
          okCount = 0;
        }
      }
    }

    if (lastNoCount != 0 && okCount > 0) {
      noCount = lastNoCount;
      noCountHistory.removeLast();
    }
    if (alternationHistory.isEmpty) alternationHistory.add(0);

    final int okCountLength = alternationHistory.length;
    double frequencyPercentage = alternationHistory.first == 0
        ? 0
        : okCountLength / (okCountLength + noCountHistory.sum()) * 100;
    // frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      final lastThree = _history.sublist(0, 3); // Pega as 3 ultimas jogadas
      if (lastThree[0] != lastThree[1] && lastThree[0] == _history[2]) {
        nextKey = lastThree[1];
      }
      median = noCountHistory.isEmpty ? 0 : noCountHistory.sum() / noCountHistory.length;

      if (noCount > 0 && noCount >= median) {
        noCountHistory.add(noCount);
        median = noCountHistory.isEmpty ? 0 : noCountHistory.sum() / noCountHistory.length;
        frequencyPercentage =
            okCountLength == 0 ? 0 : okCountLength / (okCountLength + noCountHistory.sum()) * 100;
        // frequencyPercentage *= 1.5;
      }
      if (noCount < median.round()) nextKey = null;
      if (nextKey != null) {
        final completeMedia = ((alternationHistory.sum() + (alternationHistory.length * 3)) /
                alternationHistory.length)
            .round();
        okCount += 3;
        if ((okCount) >= completeMedia) nextKey = null;
      }
    }

    if (frequencyPercentage > 100) frequencyPercentage = 100;

    // Percorrer o histórico a partir do segundo item
    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': List.generate((okCount), (i) => _history[i]).toList(),
      'frequencyRepeat': 0,
    };
  }

  // Aplica a Regra de Repetição em toda a sequência
  Map<String, dynamic> _applyRepeat() {
    final List<int> repeatHistory = [];
    final List<int> noCountHistory = [];

    int okCount = 0;
    int noCount = 0;
    int lastNoCount = 0;
    for (int i = _history.length - 1; i >= 3; i--) {
      if (_history[i] == _history[i - 1] && _history[i] == _history[i - 2]) {
        if (okCount == 0) lastNoCount = noCount;
        if (_history[i - 2] == _history[i - 3]) {
          okCount++;
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
        } else {
          noCount++;
          if (okCount > 0) {
            repeatHistory.add(okCount);
            noCount--;
          }
          okCount = 0;
        }
      }
    }

    if (lastNoCount != 0 && okCount > 0) {
      noCount = lastNoCount;
      if(noCountHistory.isNotEmpty) noCountHistory.removeLast();
    }
    if (repeatHistory.isEmpty) repeatHistory.add(0);

    final int okCountLength = repeatHistory.length;
    double frequencyPercentage =
        repeatHistory.first == 0 ? 0 : okCountLength / (okCountLength + noCountHistory.sum()) * 100;
    // frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      final lastThree = _history.sublist(0, 3); // Pega as 3 ultimas jogadas
      if (lastThree[0] == lastThree[1] && lastThree[0] == _history[2]) {
        nextKey = lastThree[0];
      }
      median = noCountHistory.isEmpty ? 0 : noCountHistory.sum() / noCountHistory.length;
      if (noCount > 0 && noCount >= median) {
        noCountHistory.add(noCount);
        median = noCountHistory.isEmpty ? 0 : noCountHistory.sum() / noCountHistory.length;
        frequencyPercentage =
            okCountLength == 0 ? 0 : okCountLength / (okCountLength + noCountHistory.sum()) * 100;
        // frequencyPercentage *= 1.5;
      }

      if (noCount < median.round()) nextKey = null;
      if (nextKey != null) {
        final completeMedia =
            ((repeatHistory.sum() + (repeatHistory.length * 3)) / repeatHistory.length).round();
        okCount += 3;

        if ((okCount) >= completeMedia) nextKey = null;
      }
    }

    if (frequencyPercentage > 100) frequencyPercentage = 100;
    // Percorrer o histórico a partir do segundo item

    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': List.generate((okCount), (i) => _history[i]).toList(),
      'frequencyRepeat': 0,
    };
  }

  // Aplica a Regra de TicTac em toda a sequência
  Map<String, dynamic> _applyTicTac() {
    final Map<String, int> okCount = {
      key1: 0,
      key2: 0,
      key3: 0,
    };

    final List<int> noCountHistory = [];

    int noCount = 0;
    // Lógica para identificar o padrão tictac
    for (int i = _history.length - 1; i > 4; i--) {
      // Verifica se há uma sequência repetida (KEY1 → KEY1)
      if (_history[i] == _history[i - 1] &&
          _history[i] == _history[i - 2] &&
          _history[i] != _history[i - 3] &&
          _history[i] != _history[i - 4]) {
        if (_history[i - 5] == _history[i]) {
          okCount[_history[i]] = (okCount[_history[i]]! + 1);
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
        } else {
          noCount++;
        }
      }
      if (noCountHistory.isEmpty) noCountHistory.add(0);
    }

    final int okCountSum = [...okCount.values].sum();
    double frequencyPercentage =
        okCountSum == 0 ? 0 : okCountSum / (okCountSum + noCountHistory.sum()) * 100;
    frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      final lastFive = _history.sublist(0, 5); // Pega as 3 ultimas jogadas
      if (lastFive[0] != lastFive[4] &&
          lastFive[1] != lastFive[4] &&
          lastFive[2] == lastFive[3] &&
          lastFive[3] == lastFive[4]) {
        nextKey = lastFive[3];
      }
      median = noCountHistory.isEmpty ? 0 : noCountHistory.sum() / noCountHistory.length;
      if (noCount > 0 && noCount >= median) {
        noCountHistory.add(noCount);
        median = noCountHistory.isEmpty ? 0 : noCountHistory.sum() / noCountHistory.length;
        frequencyPercentage =
            okCountSum == 0 ? 0 : okCountSum / (okCountSum + noCountHistory.sum()) * 100;
        frequencyPercentage *= 1.5;
      }
      if (noCount < median.round()) nextKey = null;
    }

    if (frequencyPercentage > 100) frequencyPercentage = 100;
    // Retorna as probabilidades e os pesos após aplicar a estratégia de Escadinha
    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': nextKey == null
          ? <String>[]
          : [_history[0], _history[1], _history[2], _history[3], _history[4]],
    };
  }

  // Aplica a Regra de Ausencia em toda a sequência
  Map<String, dynamic> _applyAbsence() {
    final int aPartirDe = 5;

    final Map<String, int> okCount = {
      key1: 0,
      key2: 0,
      key3: 0,
    };

    final List<int> noCountHistory = [];

    Map<String, int> counts = {
      key1: 0,
      key2: 0,
      key3: 0,
    };

    int noCount = 0;
    var (String? last, int? length) = (null, null);

    void verificaEConta(int i) {
      if (i > 2 &&
          (counts[_history[i]] as int) > aPartirDe &&
          _history[i] != _history[i - 1] &&
          _history[i] != _history[i - 2]) {
        if (_history[i] == _history[i - 3]) {
          if (noCount != 0) noCountHistory.add(noCount);
          noCount = 0;
          okCount[_history[i]] = (okCount[_history[i]] as int) + 1;
        } else {
          noCount++;
        }
      }
    }

    // Lógica para identificar o padrão absence
    for (int i = _history.length - 1; i > -1; i--) {
      // Verifica se há uma sequência repetida (KEY1 → KEY1)
      if (_history[i] == key1) {
        counts[key2] = (counts[key2] as int) + 1;
        counts[key3] = (counts[key3] as int) + 1;
        verificaEConta(i);
        counts[key1] = 0;
      } else if (_history[i] == key2) {
        counts[key1] = (counts[key1] as int) + 1;
        counts[key3] = (counts[key3] as int) + 1;
        verificaEConta(i);
        counts[key2] = 0;
      } else if (_history[i] == key3) {
        counts[key1] = (counts[key1] as int) + 1;
        counts[key2] = (counts[key2] as int) + 1;
        verificaEConta(i);
        counts[key3] = 0;
      }

      final List<String> chavesFiltradas =
          counts.entries.where((entry) => entry.value > 5).map((entry) => entry.key).toList();

      if (chavesFiltradas.isNotEmpty) {
        counts = counts.map((k, v) {
          if (k != chavesFiltradas.first) {
            return MapEntry(k, 0);
          } else {
            last = k;
            length = v;
          }
          return MapEntry(k, v);
        });
      }
    }

    if (noCountHistory.isEmpty) noCountHistory.add(0);

    final int okCountSum = [...okCount.values].sum();
    double frequencyPercentage =
        okCountSum == 0 ? 0 : okCountSum / (okCountSum + noCountHistory.sum()) * 100;
    frequencyPercentage *= 1.5;

    String? nextKey;
    var lasts = <String>[];
    if (last != null && frequencyPercentage.round() >= minProbability) {
      lasts = _history.sublist(0, length! + 4);
      if (last == lasts.last && _history[0] != last && _history[1] != last && _history[2] == last) {
        final absences = lasts.sublist(3, lasts.length - 1);
        if (absences.contains(last)) {
          last = null;
          length = null;
        }
        nextKey = last;
      }
    }

    if (frequencyPercentage > 100) frequencyPercentage = 100;

    return {
      'nextKey': nextKey,
      'median': 0,
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': lasts,
    };
  }

  // Função principal para análise
  SectorProbResultEntity analyze(ModelProbType modelProbType) {
    final alternationMap = _applyAlternation();
    final alternation = TrialProbResult.fromMap(
      map: alternationMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.alternation,
    );

    final repeatMap = _applyRepeat();
    final repeat = TrialProbResult.fromMap(
      map: repeatMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.repeat,
    );

    final ticTacMap = _applyTicTac();
    final ticTac = TrialProbResult.fromMap(
      map: ticTacMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.ticTac,
    );

    final absenceMap = _applyAbsence();
    final absence = TrialProbResult.fromMap(
      map: absenceMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.absence,
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

    print(
      'TICTAC(${ticTac.frequencyPercent}%)'
      ' => MÉDIA => ${ticTac.median}'
      ' => SUGESTAO => ${ticTac.nextKey}',
    );

    print(
      'ABSENCE(${absence.frequencyPercent}%)'
      ' => MÉDIA => ${absence.median}'
      ' => SUGESTAO => ${absence.nextKey}',
    );
    print('=================================================================');

    return SectorProbResultModel(
      modelProbType: modelProbType,
      minProbability: minProbability,
      repeat: repeat,
      alternation: alternation,
      ticTac: ticTac,
      absence: absence,
    );
  }
}
