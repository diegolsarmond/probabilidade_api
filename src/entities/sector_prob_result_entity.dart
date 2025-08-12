import '../enums/_enums.dart';
import 'trial_prob_result_entity.dart';

abstract class SectorProbResultEntity {
  late ModelProbType modelProbType;
  late int minProbability;
  late TrialProbEntity alternation;
  late TrialProbEntity repeat;
  late TrialProbEntity absence;
  late TrialProbEntity ticTac;
  bool get hasProbability;
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