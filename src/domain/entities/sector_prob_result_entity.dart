import '_entities.dart';

abstract class SectorProbResultEntity extends ProbResultEntity{
  late TrialProbEntity alternation;
  late TrialProbEntity repeat;
  late TrialProbEntity absence;
  late TrialProbEntity ticTac;
  TrialProbEntity? get highestPercent;
}

abstract class SectorProbEntity{
  late double redPercent;
  late double greenPercent;
  late double yellowPercent;
  late int redWeight;
  late int greenWeight;
  late int yellowWeight;
  late double frequencyPercent;
  Map<String, double> get percentsMap;
  Map<String, int> get weightsMap;
}