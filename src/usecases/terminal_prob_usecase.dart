import 'package:uuid/uuid.dart';

import '../constants/_constants.dart';
import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';
import '../extensions/_extensions.dart';
import '../models/_models.dart';

class TerminalProbUseCase {
  late final List<NumberEntity> _history;
  final String zero = AppConstants.zero;
  final int limit;
  final int minProbability;

  TerminalProbUseCase({
    required List<NumberEntity> history,
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
  }

  Map<String, dynamic> _applyTerminal() {
    Map<String, List<bool>> countTerminals = {};

    for (int i = 0; i <= 9; i++) {
      for (int x = 0; x <= 9; x++) {
        for (int i = 0; i <= 9; i++) {
          countTerminals['$i=>$x'] = [];
        }
      }
    }

    for (int i = _history.length - 1; i >= 1; i--) {
      var key = '${_history[i].terminalType.terminal}=>${_history[i - 1].terminalType.terminal}';
      countTerminals[key]?.add(true);
      for (int i = 0; i <= 9; i++) {
        var noCount = '${key[0]}=>$i';
        if (noCount != key) countTerminals[noCount]?.add(false);
      }
    }
    countTerminals.removeWhere(
      (k, v) => v.every((e) => !e || !k.startsWith('${_history.first.terminalType.terminal}=>')),
    );

    Map<String, int> medianNoCounts = {};
    var percentOkCountsSorted = countTerminals.map((k, v) {
      var quantityOkCount = v.where((e) => e).length;
      var percentOkCount = (quantityOkCount / v.length * 100).round();
      medianNoCounts[k] = calculateAverage(v).round();
      return MapEntry(k, percentOkCount);
    })
      ..removeWhere((k, v) => !k.startsWith('${_history.first.terminalType.terminal}=>'));

    NumberEntity? nextKey;
    var medianNoCountsActually = 0;
    var percent = 0;
    percentOkCountsSorted.removeWhere((k, v) => k != percentOkCountsSorted.keyWithMaxValue());

    if (percentOkCountsSorted.isNotEmpty) percent = percentOkCountsSorted.values.first;
    if (percent >= minProbability) {
      medianNoCounts.removeWhere((k, v) => k != percentOkCountsSorted.keys.first);
      medianNoCountsActually =
          (countTerminals[percentOkCountsSorted.keys.first]?.countTrailingFalses() ?? 0);
      var mediaNoCountsGeneral = medianNoCounts.values.first;
      if (medianNoCountsActually >= mediaNoCountsGeneral) {
        nextKey = _history.first;
      }
    }

    // print(countTerminals);
    // print(medianNoCountsActually);
    // print(medianNoCounts.values.first);
    //
    // print(countTerminals);
    // print(percentOkCountsSorted);
    // print(medianNoCounts);

    // print(percentOkCountsSorted);
    // print(countTerminals);

    return {
      'nextKey': nextKey,
      'median': medianNoCountsActually,
      'frequency': percent.round(),
    };
  }

  double calculateAverage(List<bool> list) {
    int falseCountSum = 0;
    int groupCount = 0;
    int currentFalseCount = 0;

    for (var value in list) {
      if (value == false) {
        currentFalseCount++;
      } else if (currentFalseCount > 0) {
        falseCountSum += currentFalseCount;
        groupCount++;
        currentFalseCount = 0;
      }
    }

    if (currentFalseCount > 0) {
      falseCountSum += currentFalseCount;
      groupCount++;
    }

    return groupCount > 0 ? falseCountSum / groupCount : 0.0;
  }

  TerminalProbResultEntity analyze(ModelProbType modelProbType) {
    var terminalMap = _applyTerminal();
    var terminal = TerminalProbResult.fromMap(map: terminalMap, logicType: modelProbType);
    print(
        '============================ ${modelProbType.name} =====================================');
    print(
      'TERMINAL(${terminal.frequencyPercent}%)'
      ' => MÉDIA => ${terminal.median}'
      ' => SUGESTAO => ${terminal.suggestion?.terminalType.terminal}',
    );
    print('=================================================================');
    return TerminalProbResultModel(
      id: const Uuid().v4(),
      terminal: terminal,
      modelProbType: modelProbType,
      minProbability: minProbability,
    );
  }
}
