extension IntExtension on int {
  int get getTerminal {
    if (this < 10) return this;
    return int.parse('$this'['$this'.length - 1]);
  }

  int numbersBetween(int other) {
    int lower = this < other ? this : other;
    int upper = this > other ? this : other;

    int numbersBetween = upper - lower;

    return numbersBetween < 0 ? 0 : numbersBetween;
  }
}
