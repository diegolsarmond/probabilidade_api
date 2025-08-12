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
  zero('Zero'),
  green('Verde'),
  red('Vermelho'),
  yellow('Amarelo');

  final String name;
  const SectorType(this.name);
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
  zero('Zero', 0, [0, 10, 20, 30], [26, 32, 23, 5, 1, 14, 11, 8]),
  one('Um', 1, [1, 11, 21, 31], [33, 20, 36, 30, 4, 2, 14, 9]),
  two('Dois', 2, [2, 12, 22, 32], [21, 25, 28, 35, 9, 18, 0, 15]),
  three('Tres', 3, [3, 13, 23, 33], [35, 26, 27, 36, 8, 10, 16, 1]),
  four('Quatro', 4, [4, 14, 24, 34], [19, 21, 20, 31, 5, 16, 17, 6]),
  five('Cinco', 5, [5, 15, 25, 35], [10, 24, 32, 19, 2, 17, 12, 3]),
  six('Seis', 6, [6, 16, 26, 36], [34, 27, 24, 33, 3, 0, 13, 11]),
  seven('Sete', 7, [7, 17, 27], [29, 28, 25, 34, 6, 13]),
  eight('Oito', 8, [8, 18, 28], [30, 23, 22, 29, 7, 12]),
  nine('Nove', 9, [9, 19, 29], [31, 22, 15, 4, 18, 7]);

  final String name;
  final int? terminal;
  final List<int> terminals;
  final List<int> previousNext;
  List<int> get completeTerminals => [...terminals, ...previousNext];
  const TerminalType(this.name, this.terminal, this.terminals, this.previousNext);
}

abstract class NumberEntity {
  late int number;
  late String? key;
  ColorType get colorType;
  DecadeType get decadeType;
  ColumnType get columnType;
  SectorType get sectorType;
  HighLowType get highLowType;
  EvenOddType get evenOddType;
  TerminalType get terminalType;
}
