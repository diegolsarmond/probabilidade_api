// ignore_for_file: annotate_overrides

import '../translations/charts/_charts.dart';
import '../translations/charts/prob_logics.dart';
import '../translations/modules/_modules.dart';
import '../translations/packages/_packages.dart';
import '../translations/translations.dart';
import '../translations/validators/_validators.dart';
import '../translations/widgets/loading_dialog.dart';

class En implements Translations {
  // Language code from this Translation
  String get languageCode => 'en';

  // General translations
  String welcome = 'Welcome, ';
  String defaultErrorTitle = 'We had a problem';
  String defaultErrorMessage = 'We are working to resolve it. Please try again later.';
  String lowProbability = 'No probability suggested';
  String viewDetails = 'View details';
  String viewMore = 'View more';
  String clearAll = 'Clear all';

  @override
  LoadingDialogTranslate loadingDialogTranslate = LoadingDialogTranslate(
    dialogTitle: 'Performing analysis',
    dialogSubtitle: [
      'The ',
      'Artificial Intelligence ',
      'is performing the analysis to generate the ',
      'possible ',
      'probabilities ',
    ],
  );

  @override
  HomeModuleTranslate homeModuleTranslate = HomeModuleTranslate(
    chooseNumbersTitle: 'Choice Stage',
    chooseNumbersSubTitle: 'To start the analysis, choose the numbers',
    yoursNumbersTitle: 'Your numbers',
    startAnalyseButtonLabel: 'Intelligent AI Analysis',
    yoursNumbersSubtitleWithNumbers: 'No numbers chosen so far',
    yoursNumbersSubtitleWithoutNumbers: 'Your chosen numbers so far',
    requiredNumbersWarning: 'Need to fill in at least 100 numbers',
    probabilisticModelTitle: 'Probabilistic Model',
    probabilisticModelSubtitle: 'Select the model to view the analysis',
    chooseNumber: 'Choose number',
    greaterFrequency: 'Higher frequency',
    startIAText: 'Start by choosing at least #limit numbers...',
    analysisIAText: 'Analyzing...',
    lowOrEmptyIAText: 'Insufficient numbers, continue filling...',
    foundIAText: 'I found some possibilities for you.',
    notFoundIAText: 'We haven\'t found any possibilities for now :(.',
    notFoundWithWarningIAText: 'We haven\'t found any possibilities for now. Consider '
        'readjusting the assertiveness percentage in the settings.',
  );

  @override
  ProbLogicsTranslate logicsTranslate = ProbLogicsTranslate(
    ladder: 'Ladder',
    alternation: 'Alternation',
    repeat: 'Repetition',
    ticTac: 'TicTac',
    hitAndTake: 'Hit and Take',
    absence: 'Absence',
    terminal: 'Terminal',
    repeatAbsence: 'Repetition-Absence',
  );

  @override
  DualChartTranslate colorsChartTranslate = DualChartTranslate(
    title: 'Color Analysis',
    subtitle: 'Black or red',
    k1Name: 'Red',
    k2Name: 'Black',
    transcription: [
      'Highest probability: ',
      'example: ',
      ' of ',
      '.',
    ],
  );

  @override
  DualChartTranslate evenOddChartTranslate = DualChartTranslate(
    title: 'Even or Odd Analysis',
    subtitle: 'Probability of even or odd',
    k1Name: 'Even',
    k2Name: 'Odd',
    transcription: [
      'Highest probability: ',
      'example: ',
      ' of ',
      '.',
    ],
  );

  @override
  DualChartTranslate highLowChartTranslate = DualChartTranslate(
    title: 'High or Low Analysis',
    subtitle: 'Probability of high or low',
    k1Name: 'Highs',
    k2Name: 'Lows',
    transcription: [
      'Highest probability: ',
      'example: ',
      ' of ',
      '.',
    ],
  );

  @override
  TrialChartTranslate columnChartTranslate = TrialChartTranslate(
    title: 'Column',
    subtitle: 'Column probability',
    k1Names: ['1st Column', '1st Col'],
    k2Names: ['2nd Column', '2nd Col'],
    k3Names: ['3rd Column', '3rd Col'],
    transcription: [
      'Highest probability: ',
      'example: ',
      ' of ',
      'and ',
      '.',
    ],
  );

  @override
  TrialChartTranslate decadeChartTranslate = TrialChartTranslate(
    title: 'Decade',
    subtitle: 'Decade probability',
    k1Names: ['1st Decade', '1st Dec'],
    k2Names: ['2nd Decade', '2nd Dec'],
    k3Names: ['3rd Decade', '3rd Dec'],
    transcription: [
      'Highest probability: ',
      'example: ',
      ' of ',
      'and ',
      '.',
    ],
  );

  @override
  SectorChartTranslate sectorChartTranslate = SectorChartTranslate(
    title: 'Sector',
    subtitle: 'Sector probability',
    red: 'Red',
    green: 'Green',
    yellow: 'Yellow',
    transcription: [
      'Highest probability: ',
      'example: ',
      ' of ',
      'and ',
      '.',
    ],
  );

  @override
  TerminalChartTranslate terminalChartTranslate = TerminalChartTranslate(
    title: 'Terminal',
    subtitle: 'Terminal probability',
    transcription: [
      'Highest probability: ',
      '.',
    ],
  );

  @override
  LoginModuleTranslate loginModuleTranslate = LoginModuleTranslate(
    loginTitle: 'Login',
    subtitle: 'Don\'t have an account? ',
    subtitleRegister: 'Create here',
    userInputTitle: 'Email',
    userInputHint: 'example@provider.com',
    passInputTitle: 'Password',
    passInputHint: 'Your password',
    rememberCheck: 'Remember me',
    enterButtonLabel: 'Enter',
    forgetPasswordLabel: 'Forgot password?',
    orLabel: 'or',
    enterWithGoogle: 'Sign in with Google',
    enterWithFacebook: 'Sign in with Facebook',
    errorTitleDefault: 'Could not sign in',
    errorMessageDefault: 'Check your data and try again',
    recoveryTitle: 'Recover password',
    recoverySubTitle: [
      'When ',
      'recovering password ',
      'a ',
      'link ',
      'will be sent to the entered ',
      'e-mail ',
      'to change the password',
    ],
    recoveryButtonLabel: 'Recover',
    recoveryButtonLoadingLabel: 'Sending...',
    recoverySuccessDescription: 'Recovery link sent to email\n%',
    recoveryFailTitle: 'Could not recover password',
    recoveryFailDescription: 'Check the entered e-mail or try again later',
  );

  @override
  RegisterModuleTranslate registerModuleTranslate = RegisterModuleTranslate(
    registerTitle: 'Sign Up',
    nameInputTitle: 'Name',
    nameInputHint: 'Ex. Bryan',
    emailInputTitle: 'Email',
    confirmEmailInputTitle: 'Repeat e-mail',
    userInputHint: 'example@provider.com',
    passInputTitle: 'Password',
    confirmPassInputTitle: 'Repeat password',
    passInputHint: 'Your password',
    changePhotoLabel: 'Choose photo',
    removePhotoLabel: 'Remove photo',
    registerButtonLabel: 'Create account',
    registerSuccessDescription: 'Registration successful!',
  );

  @override
  ConfigModuleTranslate configModuleTranslate = ConfigModuleTranslate(
    pageTitle: 'Settings',
    saveButtonLabel: 'Save',
    savingButtonLabel: 'Saving...',
    minNumberAnalysisTitle: 'Number of numbers considered for analysis',
    minNumberAnalysisSubtitle: 'In this field you fill in',
    minPercentageProbTitle: 'Assertiveness percentage',
    minPercentageProbSubtitle: 'In this field you fill in the minimum acceptable percentage of '
        'assertiveness for the probability suggestion to be presented',
    lowFound: 'Very risky. Use with caution.',
    moderateFound: 'Average opportunities. Good frequency, moderate risk.',
    easyFound: 'Great choice! Ideal balance between time and precision.',
    moderateLowFound: 'Strong but rare patterns. Requires patience.',
    biggerLowFound: 'If you find a pattern like this, let me know and I\'ll play too!',
    lightTheme: 'Light',
    darkTheme: 'Dark',
    systemTheme: 'System',
  );

  @override
  Map<int?, List<String>> get httpErrors => {
    404: ['Not Found', 'No data found'],
    401: ['Unauthorized', 'Your session may have expired, please log in again'],
    400: ['Unauthorized', 'Your session may have expired, please log in again'], // Or a more specific bad request message
    500: ['Server Error', 'Internal server problems, please try again later'],
  };

  @override
  FirebaseAuthTranslate firebaseAuthTranslate = FirebaseAuthTranslate.enUS(); // Assuming you have an enUs factory

  @override
  ValidatorsTranslate validatorsTranslate = ValidatorsTranslate(
    requiredField: 'Required field',
    invalidEmail: 'The e-mail entered is invalid',
    doNotMatch: 'Fields do not match',
    minLength: 'Minimum % characters', // Using % placeholder
  );
}