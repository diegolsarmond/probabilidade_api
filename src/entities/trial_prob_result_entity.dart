import '../enums/_enums.dart';

abstract class TrialProbResultEntity {
  late ModelProbType modelProbType;
  late int minProbability;
  late TrialProbEntity ladder;
  late TrialProbEntity hitAndTake;
  late TrialProbEntity repeat;
  late TrialProbEntity alternation;
  late TrialProbEntity ticTac;
  bool get hasProbability;
  TrialProbEntity? get highestPercent;
}

abstract class TrialProbEntity{
  late String key1;
  late String key2;
  late String key3;
  late int frequencyPercent;
  late String? nextKey;
  late int median;
  late List<String> distinctNumbers;
  late final LogicType logicType;
}
