import 'charts/_charts.dart';
import 'charts/prob_logics.dart';
import 'modules/_modules.dart';
import 'packages/firebase_auth.dart';
import 'validators/_validators.dart';
import 'widgets/_widgets.dart';

abstract class Translations {
  // Language code from this Translation
  String get languageCode;

  // General
  late String welcome;
  late String defaultErrorTitle;
  late String defaultErrorMessage;
  late String lowProbability;
  late String viewDetails;
  late String viewMore;
  late String clearAll;

  // Components
  late LoadingDialogTranslate loadingDialogTranslate;

  // Modules
  late HomeModuleTranslate homeModuleTranslate;
  late LoginModuleTranslate loginModuleTranslate;
  late RegisterModuleTranslate registerModuleTranslate;
  late ConfigModuleTranslate configModuleTranslate;

  // Packages
  late FirebaseAuthTranslate firebaseAuthTranslate;

  // Validations
  late ValidatorsTranslate validatorsTranslate;

  // Charts
  late ProbLogicsTranslate logicsTranslate;
  late DualChartTranslate colorsChartTranslate;
  late DualChartTranslate evenOddChartTranslate;
  late DualChartTranslate highLowChartTranslate;
  late TrialChartTranslate columnChartTranslate;
  late TrialChartTranslate decadeChartTranslate;
  late SectorChartTranslate sectorChartTranslate;

  Map<int?, List<String>> get httpErrors;
}
