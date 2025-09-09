import 'package:uuid/uuid.dart';

import '../constants/_constants.dart';
import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';
import '../extensions/_extensions.dart';
import '../models/_models.dart';

class DualProbUseCase {

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
  late final List<String> _history;
  final String key1;
  final String key2;
  final String zero = AppConstants.zero;
  final int limit;
  final int minProbability;

  Map<String, dynamic> _applyAlternation() {
    String? nextKey;

    int alternationCount = 0;
    int consecutiveCount = 1;
    List<int> consecutiveHistory = [];
    bool lastHasAlternation = false;
    int repeat = 0;

    if (_history.last == _history[_history.length - 2]) repeat++;
    for (int i = _history.length - 1; i > 1; i--) {
      if (_history[i] != _history[i - 1] && _history[i] == _history[i - 2]) {
        if (!lastHasAlternation) {
          lastHasAlternation = true;
          consecutiveCount = 3;
        } else {
          consecutiveCount++;
        }
      } else {
        repeat++;
        if (lastHasAlternation) {
          alternationCount += consecutiveCount;
          consecutiveHistory.add(consecutiveCount);
          lastHasAlternation = false;
          consecutiveCount = 1;
        }
      }
    }

    if (lastHasAlternation) {
      alternationCount += consecutiveCount;
      consecutiveHistory.add(consecutiveCount);
    } else {
      repeat++;
    }

    double historyAnalysisPercentage = alternationCount / (alternationCount + repeat) * 100;

    int median = 0;
    if (historyAnalysisPercentage > minProbability) {
      var medianList = [...consecutiveHistory]..removeLast();
      median = medianList.medianFloor();
      var lastThree = _history.sublist(0, 3);
      if (lastThree[0] != _history[1] && lastThree[0] == lastThree[2]) {
        if (lastThree.last == key1) nextKey = key2;
        if (lastThree.last == key2) nextKey = key1;
        nextKey = null;
      }
    }

    return {
      'nextKey': nextKey,
      'median': median,
      'frequency': historyAnalysisPercentage.round(),
      'distinctNumbers': 2,
    };
  }

  Map<String, dynamic> _applyRepetition() {
    var alternationMap = _applyAlternation();
    var alternationPercent = alternationMap['frequency'] as int;

    var repetitionPercent = 100 - alternationPercent;

    int median = 0;
    String? nextKey;

    if (repetitionPercent > minProbability) {
      Map<String, List<int>> repeatCountList = {key1: [], key2: []};
      var lastHasRepeat = false; // armazena se possui repeticoes nas ultimas jogadas
      var count = 0; // Conta as repeticoes
      for (int i = _history.length - 1; i > 0; i--) {
        if (_history[i] == _history[i - 1]) {
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
      count++;
      var lastThree = _history.sublist(0, 3);
      if (lastThree[0] == lastThree[1] && lastThree[1] == lastThree[2]) {
        var listCount = repeatCountList[lastThree.first];
        median = listCount!.medianFloor();
        if (lastHasRepeat && count < median) nextKey = lastThree.last;
      }
    }
    return {
      'nextKey': nextKey,
      'median': median,
      'frequency': repetitionPercent,
      'distinctNumbers': 2,
    };
  }

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
      ' => SUGESTAO => ${alternation.suggestion}',
    );
    print(
      'REPETIÇÃO(${repeat.frequencyPercent}%)'
      ' => MÉDIA => ${repeat.median}'
      ' => SUGESTAO => ${repeat.suggestion}',
    );
    print('=================================================================');
    return DualProbResultModel(
      id: const Uuid().v4(),
      alternation: alternation,
      repeat: repeat,
      modelProbType: modelProbType,
      minProbability: minProbability,
    );
  }
}
