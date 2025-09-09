import '../../enums/prob_type.dart';

abstract class ProbResultEntity {
  late String id;
  late int minProbability;
  late ModelProbType modelProbType;
  bool get hasProbability;
}
