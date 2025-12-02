import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';

class DualProbResultModel implements DualProbResultEntity {

  DualProbResultModel({
    required this.id,
    required this.alternation,
    required this.repeat,
    required this.modelProbType,
    required this.minProbability,
  });

  @override
  late final String id;

  @override
  late final ModelProbType modelProbType;

  @override
  late final DualProbEntity alternation;

  @override
  late final DualProbEntity repeat;

  @override
  late final int minProbability;

  @override
  bool get hasProbability {
    if (highestFrequencyPercent == null) return false;
    return highestFrequencyPercent!.suggestion != null &&
        highestFrequencyPercent!.frequencyPercent > minProbability;
  }

  @override
  DualProbEntity? get highestFrequencyPercent {
    DualProbEntity? maxFreq;
    if (repeat.frequencyPercent > alternation.frequencyPercent) maxFreq = repeat;
    if (repeat.frequencyPercent < alternation.frequencyPercent) maxFreq = alternation;
    return maxFreq;
  }
}

class DualProbResult implements DualProbEntity {

  DualProbResult({
    required this.key1,
    required this.key2,
    required this.frequencyPercent,
    required this.suggestion,
    required this.distinctNumbers,
    required this.median,
    required this.logicType,
  });

  factory DualProbResult.fromMap({
    required Map<String, dynamic> map,
    required String key1,
    required String key2,
    required DualLogicType logicType,
  }) {
    return DualProbResult(
      key1: key1,
      key2: key2,
      frequencyPercent: map['frequency'] as int,
      distinctNumbers: map['distinctNumbers'] as int,
      suggestion: map['nextKey'] as String?,
      median: map['median'] as int,
      logicType: logicType,
    );
  }

  @override
  Map<String, dynamic> get toMap => {
    'porcentagem': frequencyPercent,
    'sugestao': suggestion,
    'logica': logicType.nameTr,
  };

  @override
  late final double value1;

  @override
  late final double value2;

  @override
  late final String key1;

  @override
  late final String key2;

  @override
  late final int frequencyPercent;

  @override
  late final String? suggestion;

  @override
  late final int distinctNumbers;

  @override
  late final int median;

  @override
  late final DualLogicType logicType;
}
