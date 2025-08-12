abstract class PremiumProbResultEntity {
  late PremiumProbEntity terminalPushTerminal;
}

abstract class PremiumProbEntity{
  late double frequency;
  late List<int> suggestions;
  late Map<String, double>  percentsMap;
  late Map<String, int> weightsMap;
}