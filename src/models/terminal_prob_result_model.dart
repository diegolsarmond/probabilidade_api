import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';

class TerminalProbResultModel implements TerminalProbResultEntity {

  TerminalProbResultModel({
    required this.id,
    required this.terminal,
    required this.modelProbType,
    required this.minProbability,
  });

  @override
  late final String id;

  @override
  late final ModelProbType modelProbType;

  @override
  late final TerminalProbEntity terminal;

  @override
  late final int minProbability;

  @override
  bool get hasProbability {
    if (highestFrequencyPercent == null) return false;
    return highestFrequencyPercent!.suggestion != null &&
        highestFrequencyPercent!.frequencyPercent > minProbability;
  }

  @override
  TerminalProbEntity? get highestFrequencyPercent {
    TerminalProbEntity? maxFreq;
    <TerminalProbEntity, int>{
      terminal: terminal.frequencyPercent,
    }.map((k, v) {
      if (k.suggestion != null && (maxFreq?.frequencyPercent ?? 0) < v) maxFreq = k;
      return MapEntry(k, v);
    });
    return maxFreq;
  }
}

class TerminalProbResult implements TerminalProbEntity {

  TerminalProbResult({
    required this.frequencyPercent,
    required this.suggestion,
    required this.median,
    required this.logicType,
  });

  factory TerminalProbResult.fromMap({
    required Map<String, dynamic> map,
    required ModelProbType logicType,
  }) {
    return TerminalProbResult(
      frequencyPercent: map['frequency'] as int,
      suggestion: map['nextKey'] as NumberEntity?,
      median: map['median'] as int,
      logicType: logicType,
    );
  }

  @override
  Map<String, dynamic> get toMap => {
    'porcentagem': frequencyPercent,
    'sugestao': suggestion?.number,
    'logica': logicType.name,
  };

  @override
  late final int frequencyPercent;

  @override
  late final NumberEntity? suggestion;

  @override
  late final int median;


  @override
  late final ModelProbType logicType;
}
