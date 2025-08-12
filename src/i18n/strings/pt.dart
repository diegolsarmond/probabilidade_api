// ignore_for_file: annotate_overrides

import '../translations/charts/_charts.dart';
import '../translations/charts/prob_logics.dart';
import '../translations/modules/_modules.dart';
import '../translations/packages/firebase_auth.dart';
import '../translations/translations.dart';
import '../translations/validators/validators.dart';
import '../translations/widgets/loading_dialog.dart';

class Pt implements Translations {
  // Language code from this Translation
  String get languageCode => 'pt';

  // General translations
  String welcome = 'Seja bem vindo, ';
  String defaultErrorTitle = 'Tivemos um problema';
  String defaultErrorMessage = 'Estamos trabalhando para resolver. Tente novamente mais tarde.';
  String lowProbability = 'Nenhuma probabilidade sugerida';
  String viewDetails = 'Ver detalhes';
  String viewMore = 'Ver mais';
  String clearAll = 'Limpar tudo';

  @override
  LoadingDialogTranslate loadingDialogTranslate = LoadingDialogTranslate(
    dialogTitle: 'Realizando análise',
    dialogSubtitle: [
      'A ',
      'Inteligência Artificial ',
      'esta realizando a análise para gerar as ',
      'probabilidades ',
      'possíveis ',
    ],
  );

  @override
  HomeModuleTranslate homeModuleTranslate = HomeModuleTranslate(
    chooseNumbersTitle: 'Etapa da escolha',
    chooseNumbersSubTitle: 'Para iniciar a análise, escolha os números',
    yoursNumbersTitle: 'Seus números',
    startAnalyseButtonLabel: 'Análise inteligente IA',
    yoursNumbersSubtitleWithNumbers: 'Nenhum número escolhido até agora',
    yoursNumbersSubtitleWithoutNumbers: 'Seus números escolhidos até agora',
    requiredNumbersWarning: 'Necessário preencher pelo menos 100 números',
    probabilisticModelTitle: 'Modelo Probabilistico',
    probabilisticModelSubtitle: 'Selecione o modelo para visualizar a análise',
    chooseNumber: 'Escolher número',
    greaterFrequency: 'Maior frequência',
    startIAText: 'Começe escolhendo pelo menos #limit números...',
    analysisIAText: 'Analisando...',
    lowOrEmptyIAText: 'Números insuficientes, continue preenchendo...',
    foundIAText: 'Encontrei algumas possibilidades pra você.',
    notFoundIAText: 'Não Encontramos nenhuma possibilidade por enquanto :(.',
    notFoundWithWarningIAText: 'Não Encontramos nenhuma possibilidade por enquanto. Considere '
        'aumentar a assertividade nas configurações.',
  );

  @override
  ProbLogicsTranslate logicsTranslate = ProbLogicsTranslate(
    ladder: 'Escadinha',
    alternation: 'Alternância',
    repeat: 'Repetição',
    ticTac: 'TicTac',
    hitAndTake: 'Bate e Toma',
    absence: 'Ausencia',
  );

  @override
  DualChartTranslate colorsChartTranslate = DualChartTranslate(
    title: 'Análise de Cores',
    subtitle: 'Preto ou vermelho',
    k1Name: 'Vermelho',
    k2Name: 'Preto',
    transcription: [
      'Maior probabilidade: ',
      'exemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  DualChartTranslate evenOddChartTranslate = DualChartTranslate(
    title: 'Análise de Par ou Ímpar',
    subtitle: 'Probabilidade de par ou ímpar',
    k1Name: 'Par',
    k2Name: 'Ímpar',
    transcription: [
      'Maior probabilidade: ',
      'exemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  DualChartTranslate highLowChartTranslate = DualChartTranslate(
    title: 'Análise de Alto ou Baixo',
    subtitle: 'Probabilidade de alto ou baixo',
    k1Name: 'Altos',
    k2Name: 'Baixos',
    transcription: [
      'Maior probabilidade: ',
      'exemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  TrialChartTranslate columnChartTranslate = TrialChartTranslate(
    title: 'Coluna',
    subtitle: 'Probabilidade de coluna',
    k1Names: ['1º Coluna', '1º Col'],
    k2Names: ['2º Coluna', '2º Col'],
    k3Names: ['3º Coluna', '3º Col'],
    transcription: [
    'Maior probabilidade: ',
    'exemplo: ',
    ' de ',
    '.',
    ],
  );

  @override
  TrialChartTranslate decadeChartTranslate = TrialChartTranslate(
    title: 'Dezena',
    subtitle: 'Probabilidade de dezena',
    k1Names: ['1º Dezena', '1º Dez'],
    k2Names: ['2º Dezena', '2º Dez'],
    k3Names: ['3º Dezena', '3º Dez'],
    transcription: [
      'Maior probabilidade: ',
      'exemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  SectorChartTranslate sectorChartTranslate = SectorChartTranslate(
    title: 'Setor',
    subtitle: 'Probabilidade de setor',
    red: 'Vermelho',
    green: 'Verde',
    yellow: 'Amarelo',
    alternation: 'Alternância',
    absence: 'Ausência',
    repeatAbsence: 'Repetição-Ausência',
    transcription: [
      'Maior probabilidade: ',
      'exemplo: ',
      ' de ',
      '.',
    ],
  );

  @override
  LoginModuleTranslate loginModuleTranslate = LoginModuleTranslate(
    loginTitle: 'Login',
    subtitle: 'Não possui uma conta? ',
    subtitleRegister: 'Crie aqui',
    userInputTitle: 'Email',
    userInputHint: 'exemplo@provedor.com',
    passInputTitle: 'Senha',
    passInputHint: 'Sua senha',
    rememberCheck: 'Lembrar-me',
    enterButtonLabel: 'Entrar',
    forgetPasswordLabel: 'Esqueceu a senha?',
    orLabel: 'ou',
    enterWithGoogle: 'Entrar com Google',
    enterWithFacebook: 'Entrar com Facebook',
    errorTitleDefault: 'Não foi possível entrar',
    errorMessageDefault: 'Verifique os dados e tente novamente',
    recoveryTitle: 'Recuperar senha',
    recoverySubTitle: [
      'Ao ',
      'recuperar senha ',
      'será enviado para o ',
      'e-mail ',
      'digitado um ',
      'link ',
      'para alteração da senha',
    ],
    recoveryButtonLabel: 'Recuperar',
    recoveryButtonLoadingLabel: 'Enviando...',
    recoverySuccessDescription: 'Link de recuperação enviado para o email\n%',
    recoveryFailTitle: 'Não foi possível recuperar senha',
    recoveryFailDescription: 'Verifique o e-mail digitado ou tente novamente mais tarde',
  );

  @override
  RegisterModuleTranslate registerModuleTranslate = RegisterModuleTranslate(
    registerTitle: 'Registre-se',
    nameInputTitle: 'Nome',
    nameInputHint: 'Ex. Bryan',
    emailInputTitle: 'Email',
    confirmEmailInputTitle: 'Repetir e-mail',
    userInputHint: 'exemplo@provedor.com',
    passInputTitle: 'Senha',
    confirmPassInputTitle: 'Repetir senha',
    passInputHint: 'Sua senha',
    changePhotoLabel: 'Escolher foto',
    removePhotoLabel: 'Remover foto',
    registerButtonLabel: 'Criar conta',
    registerSuccessDescription: 'Cadastro realizado com sucesso!',
  );

  @override
  ConfigModuleTranslate configModuleTranslate = ConfigModuleTranslate(
    pageTitle: 'Configurações',
    saveButtonLabel: 'Salvar',
    savingButtonLabel: 'Salvando...',
    minNumberAnalysisTitle: 'Quantidade de números considerados para análise',
    minNumberAnalysisSubtitle: 'Nesse campo você preenche',
    minPercentageProbTitle: 'Porcentagem de assertividade',
    minPercentageProbSubtitle: 'Nesse campo você preenche a porcentagem mínima aceitável de '
        'assertividade para que seja apresentado a sugestão de probabilidade',
    lowFound: 'Muito arriscado. Use com cautela.',
    moderateFound: 'Oportunidades medianas. Boa frequência, risco moderado.',
    easyFound: 'Ótima escolha! Equilíbrio ideal entre tempo e precisão.',
    moderateLowFound: 'Padrões fortes, porém raros. Requer paciência.',
    biggerLowFound: 'Se achar um padrão assim, me avise que eu jogo também!',
  );

  @override
  Map<int?, List<String>> get httpErrors => {
        404: ['Não Encontrado', 'Nenhum dado encontrado'],
        401: ['Não Autorizado', 'Sua sessão pode ter expirado, entre novamente'],
        400: ['Não Autorizado', 'Sua sessão pode ter expirado, entre novamente'],
        500: ['Erro no Servidor', 'Problemas no servidor interno, tente novamente mais tarde'],
      };

  @override
  FirebaseAuthTranslate firebaseAuthTranslate = FirebaseAuthTranslate.ptBr();

  @override
  ValidatorsTranslate validatorsTranslate = ValidatorsTranslate(
    requiredField: 'Campo obrigatório',
    invalidEmail: 'O e-mail digitado é inválido',
    doNotMatch: 'Campos não coincidem',
    minLength: 'Mínimo % caracteres',
  );
}
