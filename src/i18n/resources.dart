import 'strings/en.dart';
import 'strings/es.dart';
import 'translations/translations.dart';

typedef StringChanged<T> = String Function(T value);

class R {
  static Translations strings = En();
  static List<Translations> translations = [Es()];
}
