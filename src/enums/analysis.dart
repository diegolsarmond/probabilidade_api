import '../i18n/_i18n.dart';

enum ProbStatus {
  none,
  start,
  analysis,
  lowOrEmpty,
  found,
  notFound,
  notFoundWithWarning,
}

extension ProbStatusExtension on ProbStatus {
  String get label {
    switch (this) {
      case ProbStatus.start:
        return R.strings.homeModuleTranslate.startIAText.replaceAll(
          '#limit',
          '50',
        );
      case ProbStatus.analysis:
        return R.strings.homeModuleTranslate.analysisIAText;
      case ProbStatus.lowOrEmpty:
        return R.strings.homeModuleTranslate.lowOrEmptyIAText;
      case ProbStatus.found:
        return R.strings.homeModuleTranslate.foundIAText;
      case ProbStatus.notFound:
        return R.strings.homeModuleTranslate.notFoundIAText;
      case ProbStatus.notFoundWithWarning:
        return R.strings.homeModuleTranslate.notFoundWithWarningIAText;

      default:
        '';
    }
    return '';
  }
}
