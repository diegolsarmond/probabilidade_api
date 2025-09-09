import 'package:equatable/equatable.dart';

import '../domain/entities/_entities.dart';

class PinnedProb extends Equatable {

  PinnedProb({
    required this.probResult,
    required this.repeat,
    this.count = 0,
  }) : id = probResult.id;
  final String id;
  final ProbResultEntity probResult;
  final int repeat;
  int count;

  bool get expired => count > repeat;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PinnedProb && other.id == id;
  }

  @override
  List<Object?> get props => [id, probResult];
}
