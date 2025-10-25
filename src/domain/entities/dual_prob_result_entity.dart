import '../../i18n/resources.dart';
import '_entities.dart';

abstract class DualProbResultEntity extends ProbResultEntity{
  late DualProbEntity alternation;
  late DualProbEntity repeat;
  DualProbEntity? get highestFrequencyPercent;
}

abstract class DualProbEntity{
  late String key1;
  late String key2;
  late double value1;
  late double value2;
  late int frequencyPercent;
  late String? suggestion;
  late int distinctNumbers;
  late int median;
  late DualLogicType logicType;
  Map<String, dynamic> get toMap;
}

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
