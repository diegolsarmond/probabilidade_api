extension ListIntExtensions on List<int> {
  int sum() {
    if (isEmpty) return 0;
    return reduce((value, element) => value + element);
  }

  int medianFloor() {
    if (isEmpty) return 0;
    return (sum() / length).floor();
  }

  int medianRound() {
    if (isEmpty) return 0;
    return (sum() / length).round();
  }

}

extension ListBoolExtensions on List<bool> {
  int countTrailingFalses() {
    int lastTrueIndex = lastIndexWhere((e) => e);
    return length - 1 - lastTrueIndex;
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    var ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this)
      ..retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }

  void clearAddAll(Iterable<E> values) {
    clear();
    addAll(values);
  }
}

