extension ListExtensions on List<int> {
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
