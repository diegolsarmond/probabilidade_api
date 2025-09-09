import 'package:uuid/uuid.dart';

import '../constants/_constants.dart';
import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';
import '../extensions/_extensions.dart';
import '../models/_models.dart';

class TrialProbUseCase {
  late final List<String> _history;
  final String key1;
  final String key2;
  final String key3;
  final String zero = AppConstants.zero;
  final int limit;
  final int minProbability;

  TrialProbUseCase({
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

  Map<String, dynamic> _applyAlternation() {
    List<int> alternationHistory = [];
    List<int> noCountHistory = [];

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

    int okCountLength = alternationHistory.length;
    double frequencyPercentage = alternationHistory.first == 0
        ? 0
        : okCountLength / (okCountLength + noCountHistory.sum()) * 100;
    // frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      var lastThree = _history.sublist(0, 3); // Pega as 3 ultimas jogadas
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
        var completeMedia = ((alternationHistory.sum() + (alternationHistory.length * 3)) /
            alternationHistory.length)
            .round();
        okCount += 3;
        if ((okCount) >= completeMedia) nextKey = null;
      }
    }

    if (frequencyPercentage > 100) frequencyPercentage = 100;

    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': List.generate((okCount), (i) => _history[i]).toList(),
      'frequencyRepeat': 0,
    };
  }

  Map<String, dynamic> _applyRepeat() {
    List<int> repeatHistory = [];
    List<int> noCountHistory = [];

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

    int okCountLength = repeatHistory.length;
    double frequencyPercentage =
    repeatHistory.first == 0 ? 0 : okCountLength / (okCountLength + noCountHistory.sum()) * 100;
    // frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      var lastThree = _history.sublist(0, 3);
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
        var completeMedia =
        ((repeatHistory.sum() + (repeatHistory.length * 3)) / repeatHistory.length).round();
        okCount += 3;

        if ((okCount) >= completeMedia) nextKey = null;
      }
    }

    if (frequencyPercentage > 100) frequencyPercentage = 100;

    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': List.generate((okCount), (i) => _history[i]).toList(),
      'frequencyRepeat': 0,
    };
  }

  Map<String, dynamic> _applyLadder() {
    Map<String, int> okCount = {
      key1: 0,
      key3: 0,
    };

    List<int> noCountHistory = [];

    int noCount = 0;
    for (int i = _history.length - 1; i > 1; i--) {
      if (_history[i] == key1 && _history[i - 1] == key2) {
        if (_history[i - 2] == key3) {
          okCount[key3] = (okCount[key3]! + 1);
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
        } else {
          noCount++;
        }
      } else if (_history[i] == key3 && _history[i - 1] == key2) {
        if (_history[i - 2] == key1) {
          okCount[key1] = (okCount[key1]! + 1);
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
        } else {
          noCount++;
        }
      }
    }
    if (noCountHistory.isEmpty) noCountHistory.add(0);

    int okCountSum = [...okCount.values].sum();
    double frequencyPercentage =
        okCountSum == 0 ? 0 : okCountSum / (okCountSum + noCountHistory.sum()) * 100;
    if (frequencyPercentage < 66) frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      var lastThree = _history.sublist(0, 2);
      if (lastThree.last == key3 && lastThree.first == key2) {
        nextKey = key1;
      } else if (lastThree.last == key1 && lastThree.first == key2) {
        nextKey = key3;
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
    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': [_history[0], _history[1]],
    };
  }

  Map<String, dynamic> _applyHitAndTake() {
    Map<String, int> okCount = {
      key1: 0,
      key2: 0,
      key3: 0,
    };

    List<int> noCountHistory = [];

    int noCount = 0;
    for (int i = _history.length - 1; i > 1; i--) {
      if (_history[i] == _history[i - 1]) {
        if (_history[i - 2] == _history[i]) {
          okCount[_history[i]] = (okCount[_history[i]]! + 1);
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
          i -= 2;
        } else {
          noCount++;
        }
      }
    }
    if (noCountHistory.isEmpty) noCountHistory.add(0);

    int okCountSum = [...okCount.values].sum();
    double frequencyPercentage =
        okCountSum == 0 ? 0 : okCountSum / (okCountSum + noCountHistory.sum()) * 100;
    if (frequencyPercentage < 66) frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      var lastTwo = _history.sublist(0, 2);
      if (lastTwo[0] == lastTwo[1]) nextKey = lastTwo[0];
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
    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': [_history[0], _history[1]],
    };
  }

  Map<String, dynamic> _applyTicTac() {
    Map<String, int> okCount = {
      key1: 0,
      key2: 0,
      key3: 0,
    };

    List<int> noCountHistory = [];

    int noCount = 0;
    for (int i = _history.length - 1; i > 2; i--) {
      if (_history[i] == _history[i - 1] && _history[i] != _history[i - 2]) {
        if (_history[i - 3] == _history[i]) {
          okCount[_history[i]] = (okCount[_history[i]]! + 1);
          if (noCount > 0) noCountHistory.add(noCount);
          noCount = 0;
        } else {
          noCount++;
        }
      }
    }
    if (noCountHistory.isEmpty) noCountHistory.add(0);

    int okCountSum = [...okCount.values].sum();
    double frequencyPercentage =
        okCountSum == 0 ? 0 : okCountSum / (okCountSum + noCountHistory.sum()) * 100;
    if (frequencyPercentage < 66) frequencyPercentage *= 1.5;

    double median = 0;
    String? nextKey;

    if (frequencyPercentage.round() >= minProbability) {
      var lastThree = _history.sublist(0, 3);
      if (lastThree[0] != lastThree[1] && lastThree[1] == lastThree[2]) nextKey = lastThree[2];
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
    return {
      'nextKey': nextKey,
      'median': median.round(),
      'frequency': frequencyPercentage.round(),
      'distinctNumbers': [_history[0], _history[1], _history[2]],
    };
  }

  // Função principal para análise
  TrialProbResultEntity analyze(ModelProbType modelProbType) {
    var alternationMap = _applyAlternation();
    var alternation = TrialProbResult.fromMap(
      map: alternationMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.alternation,
    );

    var repeatMap = _applyRepeat();
    var repeat = TrialProbResult.fromMap(
      map: repeatMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.repeat,
    );

    var ladderMap = _applyLadder();
    var ladder = TrialProbResult.fromMap(
      map: ladderMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.ladder,
    );

    var hitAndTakeMap = _applyHitAndTake();
    var hitAndTake = TrialProbResult.fromMap(
      map: hitAndTakeMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.hitAndTake,
    );

    var ticTacMap = _applyTicTac();
    var ticTac = TrialProbResult.fromMap(
      map: ticTacMap,
      key1: key1,
      key2: key2,
      key3: key3,
      logicType: LogicType.ticTac,
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
    print(
      'ESCADINHA(${ladder.frequencyPercent}%)'
      ' => MÉDIA => ${ladder.median}'
      ' => SUGESTAO => ${ladder.suggestion}',
    );
    print(
      'BATE E TOMA(${hitAndTake.frequencyPercent}%)'
      ' => MÉDIA => ${hitAndTake.median}'
      ' => SUGESTAO => ${hitAndTake.suggestion}',
    );
    print(
      'TICTAC(${ticTac.frequencyPercent}%)'
      ' => MÉDIA => ${ticTac.median}'
      ' => SUGESTAO => ${ticTac.suggestion}',
    );
    print('=================================================================');

    return TrialProbResultModel(
      id: const Uuid().v4(),
      modelProbType: modelProbType,
      minProbability: minProbability,
      ladder: ladder,
      hitAndTake: hitAndTake,
      repeat: repeat,
      alternation: alternation,
      ticTac: ticTac,
    );
  }
}
