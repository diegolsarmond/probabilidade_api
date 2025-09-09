enum ColorType {
  zero('Zero'),
  red('Vermelho'),
  black('Preto');

  final String name;
  const ColorType(this.name);
}

enum EvenOddType {
  zero('Zero'),
  even('Par'),
  odd('Ímpar');

  final String name;
  const EvenOddType(this.name);
}

enum SectorType {
  zero('Zero', 0),
  green('Verde', 29),
  red('Vermelho', 2),
  yellow('Amarelo', 10);

  final String name;
  final int center;

  static SectorType getSector(String sectorName) => values.singleWhere((e) => e.name == sectorName);
  const SectorType(this.name, this.center);
}

enum DecadeType {
  zero('Zero'),
  first('D1'),
  second('D2'),
  third('D3');

  final String name;
  const DecadeType(this.name);
}

enum ColumnType {
  zero('Zero'),
  first('C1'),
  second('C2'),
  third('C3');

  final String name;
  const ColumnType(this.name);
}

enum HighLowType {
  zero('Zero'),
  high('Alto'),
  low('Baixo');

  final String name;
  const HighLowType(this.name);
}

enum TerminalType {
  zero({
    0: [26, 32],
    10: [23, 5],
    20: [1, 14],
    30: [11, 8]
  }),
  one({
    1: [33, 20],
    11: [36, 30],
    21: [4, 2],
    31: [14, 9]
  }),
  two({
    2: [21, 25],
    12: [28, 35],
    22: [9, 18],
    32: [0, 15]
  }),
  three({
    3: [35, 26],
    13: [27, 36],
    23: [8, 10],
    33: [16, 1]
  }),
  four({
    4: [19, 21],
    14: [20, 31],
    24: [5, 16],
    34: [17, 6]
  }),
  five({
    5: [10, 24],
    15: [32, 19],
    25: [2, 17],
    35: [12, 3]
  }),
  six({
    6: [34, 27],
    16: [24, 33],
    26: [3, 0],
    36: [13, 11]
  }),
  seven({
    7: [29, 28],
    17: [25, 34],
    27: [6, 13]
  }),
  eight({
    8: [30, 23],
    18: [22, 29],
    28: [7, 12]
  }),
  nine({
    9: [31, 22],
    19: [15, 4],
    29: [18, 7]
  });

  final Map<int, List<int>> terminalSides;
  int get terminal => terminalSides.keys.first;
  const TerminalType(this.terminalSides);
}

abstract class NumberEntity {
  late int number;
  late String? key;
  late DateTime? dateHour;
  ColorType get colorType;
  DecadeType get decadeType;
  ColumnType get columnType;
  SectorType get sectorType;
  HighLowType get highLowType;
  EvenOddType get evenOddType;
  TerminalType get terminalType;
}
