import '../dual_prob_usecase.dart';
import '../enums/_enums.dart';

abstract class DualProbResultEntity {
  late ModelProbType modelProbType;
  late DualProbEntity alternation;
  late DualProbEntity repeat;
  DualProbEntity? get highestFrequencyPercent;
  bool get hasProbability;
  late int minProbability;
}

abstract class DualProbEntity{
  late String key1;
  late String key2;
  late double value1;
  late double value2;
  late int frequencyPercent;
  late String? nextKey;
  late int distinctNumbers;
  late int median;
  late DualLogicType logicType;
}