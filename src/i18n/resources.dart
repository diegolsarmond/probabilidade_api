import 'strings/_strings.dart';
import 'translations/translations.dart';

typedef StringChanged<T> = String Function(T value);

class R {
  static Translations strings = Pt();
  static List<Translations> translations = [Pt()];

  static void load() {
    strings =  Pt();
  }
}
