import '../../enums/_enums.dart';
import '_entities.dart';

abstract class TerminalProbResultEntity extends ProbResultEntity{
  late TerminalProbEntity terminal;
  TerminalProbEntity? get highestFrequencyPercent;
}

abstract class TerminalProbEntity{
  late int frequencyPercent;
  late NumberEntity? suggestion;
  late int median;
  late ModelProbType logicType;
}