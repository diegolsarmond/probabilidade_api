import '../i18n/_i18n.dart';

enum LogicType {
  alternation,
  repeat,
  ladder,
  ticTac,
  absence,
  hitAndTake;

  String get nameTr {
    switch (this) {
      case LogicType.alternation:
        return R.strings.logicsTranslate.alternation;
      case LogicType.repeat:
        return R.strings.logicsTranslate.repeat;
      case LogicType.ladder:
        return R.strings.logicsTranslate.ladder;
      case LogicType.hitAndTake:
        return R.strings.logicsTranslate.hitAndTake;
      case LogicType.ticTac:
        return R.strings.logicsTranslate.ticTac;
      case LogicType.absence:
        return R.strings.logicsTranslate.absence;
    }
  }
}