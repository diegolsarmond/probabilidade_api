import 'dart:math';
import 'package:uuid/uuid.dart';

import '../domain/entities/_entities.dart';
import '../extensions/_extensions.dart';

class NumberItem implements NumberEntity {
  @override
  late int number;
  @override
  late String? key;

  @override
  late final DateTime? dateHour;

  @override
  ColorType get colorType => number == 0
      ? ColorType.zero
      : [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36].contains(number)
          ? ColorType.red
          : [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35].contains(number)
              ? ColorType.black
              : ColorType.zero;
  @override
  DecadeType get decadeType => number == 0
      ? DecadeType.zero
      : number < 13 && number > 0
          ? DecadeType.first
          : number >= 13 && number <= 24
              ? DecadeType.second
              : number > 24
                  ? DecadeType.third
                  : DecadeType.zero;
  @override
  ColumnType get columnType => [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34].contains(number)
      ? ColumnType.first
      : [2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35].contains(number)
          ? ColumnType.second
          : [3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36].contains(number)
              ? ColumnType.third
              : ColumnType.zero;
  @override
  SectorType get sectorType => [32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13].contains(number)
      ? SectorType.red
      : [36, 11, 30, 8, 23, 10, 5, 24, 16, 33, 1, 20].contains(number)
          ? SectorType.yellow
          : [26, 3, 35, 12, 28, 7, 29, 18, 22, 9, 31, 14].contains(number)
              ? SectorType.green
              : SectorType.zero;

  @override
  HighLowType get highLowType => number > 0 && number < 19
      ? HighLowType.low
      : number >= 19
          ? HighLowType.high
          : HighLowType.zero;

  @override
  EvenOddType get evenOddType => number == 0
      ? EvenOddType.zero
      : number % 2 == 0
          ? EvenOddType.even
          : EvenOddType.odd;

  @override
  TerminalType get terminalType {
    return TerminalType.one.terminal == number.getTerminal
      ? TerminalType.one
      : TerminalType.two.terminal == number.getTerminal
          ? TerminalType.two
          : TerminalType.three.terminal == number.getTerminal
              ? TerminalType.three
              : TerminalType.four.terminal == number.getTerminal
                  ? TerminalType.four
                  : TerminalType.five.terminal == number.getTerminal
                      ? TerminalType.five
                      : TerminalType.six.terminal == number.getTerminal
                          ? TerminalType.six
                          : TerminalType.seven.terminal == number.getTerminal
                              ? TerminalType.seven
                              : TerminalType.eight.terminal == number.getTerminal
                                  ? TerminalType.eight
                                  : TerminalType.nine.terminal == number.getTerminal
                                      ? TerminalType.nine
                                      : TerminalType.zero;
  }

  NumberItem({
    this.key,
    required this.number,
    this.dateHour,
  }) : assert(number <= 36);

  factory NumberItem.generateWithKey(NumberEntity number) {
    return NumberItem(
      key: const Uuid().v4(),
      number: number.number,
      dateHour: DateTime.now(),
    );
  }

}
