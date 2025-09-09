// ignore_for_file: annotate_overrides

import '../translations/charts/_charts.dart';
import '../translations/charts/prob_logics.dart';
import '../translations/modules/_modules.dart';
import '../translations/packages/firebase_auth.dart';
import '../translations/translations.dart';
import '../translations/validators/validators.dart';
import '../translations/widgets/loading_dialog.dart';

class Es implements Translations {
  // Language code from this Translation
  String get languageCode => 'es';

  // General translations
  String welcome = 'Bienvenido, ';
  String defaultErrorTitle = 'Tuvimos un problema';
  String defaultErrorMessage = 'Estamos trabajando para resolverlo. Inténtalo de nuevo más tarde.';
  String lowProbability = 'Ninguna probabilidad sugerida';
  String viewDetails = 'Ver detalles';
  String viewMore = 'Ver más';
  String clearAll = 'Limpiar todo';

  @override
  LoadingDialogTranslate loadingDialogTranslate = LoadingDialogTranslate(
    dialogTitle: 'Realizando análisis',
    dialogSubtitle: [
      'La ',
      'Inteligencia Artificial ',
      'está realizando el análisis para generar las ',
      'probabilidades ',
      'posibles ',
    ],
  );

  @override
  HomeModuleTranslate homeModuleTranslate = HomeModuleTranslate(
    chooseNumbersTitle: 'Etapa de elección',
    chooseNumbersSubTitle: 'Para iniciar el análisis, elige los números',
    yoursNumbersTitle: 'Tus números',
    startAnalyseButtonLabel: 'Análisis inteligente IA',
    yoursNumbersSubtitleWithNumbers: 'Ningún número elegido hasta ahora',
    yoursNumbersSubtitleWithoutNumbers: 'Tus números elegidos hasta ahora',
    requiredNumbersWarning: 'Es necesario rellenar al menos 100 números',
    probabilisticModelTitle: 'Modelo Probabilístico',
    probabilisticModelSubtitle: 'Selecciona el modelo para visualizar el análisis',
    chooseNumber: 'Elegir número',
    greaterFrequency: 'Mayor frecuencia',
    startIAText: 'Comienza eligiendo al menos #limit números...',
    analysisIAText: 'Analizando...',
    lowOrEmptyIAText: 'Números insuficientes, continúa rellenando...',
    foundIAText: 'Encontré algunas posibilidades para ti.',
    notFoundIAText: 'No hemos encontrado ninguna posibilidad por ahora :(.',
    notFoundWithWarningIAText: 'No hemos encontrado ninguna posibilidad por ahora. Considera '
        'reajustar el porcentaje de asertividad en la configuración.',
  );

  @override
  ProbLogicsTranslate logicsTranslate = ProbLogicsTranslate(
    ladder: 'Escalerita',
    alternation: 'Alternancia',
    repeat: 'Repetición',
    ticTac: 'TicTac',
    hitAndTake: 'Golpea y Toma', // Or a more natural Spanish equivalent
    absence: 'Ausencia',
    terminal: 'Terminal',
    repeatAbsence: 'Repetición-Ausencia',
  );

  @override
  DualChartTranslate colorsChartTranslate = DualChartTranslate(
    title: 'Análisis de Colores',
    subtitle: 'Negro o rojo',
    k1Name: 'Rojo',
    k2Name: 'Negro',
    transcription: [
      'Mayor probabilidad: ',
      'ejemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  DualChartTranslate evenOddChartTranslate = DualChartTranslate(
    title: 'Análisis de Par o Impar',
    subtitle: 'Probabilidad de par o impar',
    k1Name: 'Par',
    k2Name: 'Impar',
    transcription: [
      'Mayor probabilidad: ',
      'ejemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  DualChartTranslate highLowChartTranslate = DualChartTranslate(
    title: 'Análisis de Alto o Bajo',
    subtitle: 'Probabilidad de alto o bajo',
    k1Name: 'Altos',
    k2Name: 'Bajos',
    transcription: [
      'Mayor probabilidad: ',
      'ejemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  TrialChartTranslate columnChartTranslate = TrialChartTranslate(
    title: 'Columna',
    subtitle: 'Probabilidad de columna',
    k1Names: ['1ª Columna', '1ª Col'],
    k2Names: ['2ª Columna', '2ª Col'],
    k3Names: ['3ª Columna', '3ª Col'],
    transcription: [
      'Mayor probabilidad: ',
      'ejemplo: ',
      ' de ',
      'y ',
      '.',
    ],
  );

  @override
  TrialChartTranslate decadeChartTranslate = TrialChartTranslate(
    title: 'Decena',
    subtitle: 'Probabilidad de decena',
    k1Names: ['1ª Decena', '1ª Dec'],
    k2Names: ['2ª Decena', '2ª Dec'],
    k3Names: ['3ª Decena', '3ª Dec'],
    transcription: [
      'Mayor probabilidad: ',
      'ejemplo: ',
      ' de ',
      'y ',
      '.',
    ],
  );

  @override
  SectorChartTranslate sectorChartTranslate = SectorChartTranslate(
    title: 'Sector',
    subtitle: 'Probabilidad de sector',
    red: 'Rojo',
    green: 'Verde',
    yellow: 'Amarillo',
    transcription: [
      'Mayor probabilidad: ',
      'ejemplo: ',
      ' de ',
      'y ',
      '.',
    ],
  );

  @override
  TerminalChartTranslate terminalChartTranslate = TerminalChartTranslate(
    title: 'Terminal',
    subtitle: 'Probabilidad de terminal',
    transcription: [
      'Mayor probabilidad: ',
      '.',
    ],
  );

  @override
  LoginModuleTranslate loginModuleTranslate = LoginModuleTranslate(
    loginTitle: 'Iniciar sesión',
    subtitle: '¿No tienes una cuenta? ',
    subtitleRegister: 'Crea una aquí',
    userInputTitle: 'Correo electrónico',
    userInputHint: 'ejemplo@proveedor.com',
    passInputTitle: 'Contraseña',
    passInputHint: 'Tu contraseña',
    rememberCheck: 'Recordarme',
    enterButtonLabel: 'Entrar',
    forgetPasswordLabel: '¿Olvidaste tu contraseña?',
    orLabel: 'o',
    enterWithGoogle: 'Entrar con Google',
    enterWithFacebook: 'Entrar con Facebook',
    errorTitleDefault: 'No se pudo iniciar sesión',
    errorMessageDefault: 'Verifica tus datos e inténtalo de nuevo',
    recoveryTitle: 'Recuperar contraseña',
    recoverySubTitle: [
      'Al ',
      'recuperar la contraseña ',
      'se enviará al ',
      'correo electrónico ',
      'ingresado un ',
      'enlace ',
      'para cambiar la contraseña',
    ],
    recoveryButtonLabel: 'Recuperar',
    recoveryButtonLoadingLabel: 'Enviando...',
    recoverySuccessDescription: 'Enlace de recuperación enviado al correo electrónico\n%',
    recoveryFailTitle: 'No se pudo recuperar la contraseña',
    recoveryFailDescription: 'Verifica el correo electrónico ingresado o inténtalo de nuevo más tarde',
  );

  @override
  RegisterModuleTranslate registerModuleTranslate = RegisterModuleTranslate(
    registerTitle: 'Regístrate',
    nameInputTitle: 'Nombre',
    nameInputHint: 'Ej. Bryan',
    emailInputTitle: 'Correo electrónico',
    confirmEmailInputTitle: 'Repetir correo electrónico',
    userInputHint: 'ejemplo@proveedor.com',
    passInputTitle: 'Contraseña',
    confirmPassInputTitle: 'Repetir contraseña',
    passInputHint: 'Tu contraseña',
    changePhotoLabel: 'Elegir foto',
    removePhotoLabel: 'Quitar foto',
    registerButtonLabel: 'Crear cuenta',
    registerSuccessDescription: '¡Registro realizado con éxito!',
  );

  @override
  ConfigModuleTranslate configModuleTranslate = ConfigModuleTranslate(
    pageTitle: 'Configuración',
    saveButtonLabel: 'Guardar',
    savingButtonLabel: 'Guardando...',
    minNumberAnalysisTitle: 'Cantidad de números considerados para el análisis',
    minNumberAnalysisSubtitle: 'En este campo completas',
    minPercentageProbTitle: 'Porcentaje de asertividad',
    minPercentageProbSubtitle: 'En este campo completas el porcentaje mínimo aceptable de '
        'asertividad para que se presente la sugerencia de probabilidad',
    lowFound: 'Muy arriesgado. Úsalo con precaución.',
    moderateFound: 'Oportunidades medias. Buena frecuencia, riesgo moderado.',
    easyFound: '¡Excelente elección! Equilibrio ideal entre tiempo y precisión.',
    moderateLowFound: 'Patrones fuertes, pero raros. Requiere paciencia.',
    biggerLowFound: 'Si encuentras un patrón así, ¡avísame que yo también juego!',
    lightTheme: 'Claro',
    darkTheme: 'Oscuro',
    systemTheme: 'Sistema',
  );

  @override
  Map<int?, List<String>> get httpErrors => {
    404: ['No Encontrado', 'Ningún dato encontrado'],
    401: ['No Autorizado', 'Tu sesión puede haber expirado, inicia sesión de nuevo'],
    400: ['Solicitud Incorrecta', 'Tu sesión puede haber expirado, inicia sesión de nuevo'], // Or a more general "Bad Request"
    500: ['Error del Servidor', 'Problemas en el servidor interno, inténtalo de nuevo más tarde'],
  };

  @override
  FirebaseAuthTranslate firebaseAuthTranslate = FirebaseAuthTranslate.es(); // Assuming you have an .es() factory

  @override
  ValidatorsTranslate validatorsTranslate = ValidatorsTranslate(
    requiredField: 'Campo obligatorio',
    invalidEmail: 'El correo electrónico ingresado es inválido',
    doNotMatch: 'Los campos no coinciden',
    minLength: 'Mínimo % caracteres',
  );
}
