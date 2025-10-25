import 'strings/_strings.dart';
import 'strings/en.dart';
import 'strings/es.dart';
import 'translations/translations.dart';

typedef StringChanged<T> = String Function(T value);

class R {
  static Translations strings = Pt();
  static List<Translations> translations = [Pt(), Es(), En()];

  static void load(String locale) {
    strings = translations.singleWhere(
          (tr) {
        return tr.languageCode == locale;
      },
      orElse: () => Pt(),
    );
  }
}
