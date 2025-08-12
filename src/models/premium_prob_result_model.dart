
import '../entities/_entities.dart';

class PremiumProbResultModel implements PremiumProbResultEntity {

  PremiumProbResultModel({
    required this.terminalPushTerminal,
  });
  @override
  PremiumProbEntity terminalPushTerminal;
}

class PremiumProbResult implements PremiumProbEntity {

  PremiumProbResult({
    required this.suggestions,
    required this.frequency,
    required this.percentsMap,
    required this.weightsMap,
  });
  @override
  late final List<int> suggestions;

  @override
  late final double frequency;

  @override
  late final Map<String, double> percentsMap;

  @override
  late final Map<String, int> weightsMap;
}
