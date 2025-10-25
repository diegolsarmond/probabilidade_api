import '../../enums/_enums.dart';
import '_entities.dart';

abstract class TrialProbResultEntity extends ProbResultEntity{
  late TrialProbEntity ladder;
  late TrialProbEntity hitAndTake;
  late TrialProbEntity repeat;
  late TrialProbEntity alternation;
  late TrialProbEntity ticTac;
  TrialProbEntity? get highestPercent;
}

abstract class TrialProbEntity{
  late String key1;
  late String key2;
  late String key3;
  late int frequencyPercent;
  late String? suggestion;
  late int median;
  late List<String> distinctNumbers;
  late final LogicType logicType;
  Map<String, dynamic> get toMap;
}