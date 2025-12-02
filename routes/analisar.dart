import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../src/domain/entities/_entities.dart';
import '../src/enums/_enums.dart';
import '../src/i18n/_i18n.dart';
import '../src/models/_models.dart';
import '../src/usecases/_usecases.dart';

final probabilities = <ProbResultEntity>[];

Future<Response> onRequest(RequestContext context) async {
  try {
    final body = await context.request.body();
    final data = jsonDecode(body);
    final response = _validateFields(data as Map<String, dynamic>, context);

    if (response == null) {
      final locale = context.request.uri.queryParameters['idioma'];
      if (locale != null) R.load(locale);
      final numbersInt = List.of(data['numeros'] as List).cast<int>();
      if (numbersInt.any((e) => e > 36)) {
        return Response(
          statusCode: 400,
          body: 'Os números inseridos devem estar entre 0 e 36',
        );
      }
      final numbers = List<NumberEntity>.from(numbersInt.map((e) => NumberItem(number: e))).toList();

      _analyze(numbers, data['limiteNumeros'] as int, data['minimoPorcento'] as int);
      return Response.json(
        body: probabilities.map(_getLogicData).toList(),
      );
    }

    return response;
  } catch (error, stack) {
    print(stack);
    return Response(statusCode: 500, body: error.toString());
  }
}

Response? _validateFields(Map<String, dynamic> data, RequestContext context) {
  if (data.isEmpty) {
    return Response(
      statusCode: 400,
      body: 'é necessário informar limiteNumeros, minimoPorcento e numeros',
    );
  } else if (!data.containsKey('limiteNumeros') ||
      data['limiteNumeros']! is bool ||
      data['limiteNumeros'] == null ||
      data['limiteNumeros'] == '') {
    return Response(
      statusCode: 400,
      body: 'O campo limiteNumeros é obrigatório',
    );
  } else if (!data.containsKey('minimoPorcento') ||
      data['minimoPorcento']! is bool ||
      data['minimoPorcento'] == null ||
      data['minimoPorcento'] == '') {
    return Response(
      statusCode: 400,
      body: 'O campo minimoPorcento é obrigatório',
    );
  } else if (!data.containsKey('numeros') ||
      data['numeros']! is bool ||
      data['numeros'] == null ||
      data['numeros'] == '') {
    return Response(
      statusCode: 400,
      body: 'O campo numeros é obrigatório',
    );
  }
}

void _analyze(List<NumberEntity> numbers, int minAnalysis, int minPercentage) {
  final colorProbResult = DualProbUseCase(
    history: numbers.reversed.map((e) => e.colorType.name).toList(),
    key1: ColorType.red.name,
    key2: ColorType.black.name,
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.colors);
  final evenOddProbResult = DualProbUseCase(
    history: numbers.reversed.map((e) => e.evenOddType.name).toList(),
    key1: EvenOddType.even.name,
    key2: EvenOddType.odd.name,
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.evenOdd);
  final highLowProbResult = DualProbUseCase(
    history: numbers.reversed.map((e) => e.highLowType.name).toList(),
    key1: HighLowType.high.name,
    key2: HighLowType.low.name,
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.highLow);
  final decadeProbResult = TrialProbUseCase(
    history: numbers.reversed.map((e) => e.decadeType.name).toList(),
    key1: DecadeType.first.name,
    key2: DecadeType.second.name,
    key3: DecadeType.third.name,
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.decade);
  final columnProbResult = TrialProbUseCase(
    history: numbers.reversed.map((e) => e.columnType.name).toList(),
    key1: ColumnType.first.name,
    key2: ColumnType.second.name,
    key3: ColumnType.third.name,
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.columns);
  final sectorProbResult = SectorProbUseCase(
    history: numbers.reversed.map((e) => e.sectorType.name).toList(),
    key1: SectorType.red.name,
    key2: SectorType.green.name,
    key3: SectorType.yellow.name,
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.sectors);
  final terminalProbResult = TerminalProbUseCase(
    history: numbers.reversed.toList(),
    limit: minAnalysis,
    minProbability: minPercentage,
  ).analyze(ModelProbType.terminal);

  final sortedProbMap = <ModelProbType, ProbResultEntity>{
    ModelProbType.colors: colorProbResult,
    ModelProbType.evenOdd: evenOddProbResult,
    ModelProbType.highLow: highLowProbResult,
    ModelProbType.columns: columnProbResult,
    ModelProbType.decade: decadeProbResult,
    ModelProbType.sectors: sectorProbResult,
    ModelProbType.terminal: terminalProbResult,
  }..removeWhere((k, v) => !v.hasProbability);

  probabilities
    ..clear()
    ..addAll(sortedProbMap.values);
}

Map<String, dynamic>? _getLogicData(ProbResultEntity probResult) {
  if (probResult.modelProbType == ModelProbType.colors) {
    final colorsProbResult = probResult as DualProbResultEntity;
    return colorsProbResult.highestFrequencyPercent?.toMap;
  } else if (probResult.modelProbType == ModelProbType.evenOdd) {
    final evenOddProbResult = probResult as DualProbResultEntity;
    return evenOddProbResult.highestFrequencyPercent?.toMap;
  } else if (probResult.modelProbType == ModelProbType.highLow) {
    final highLowProbResult = probResult as DualProbResultEntity;
    return highLowProbResult.highestFrequencyPercent?.toMap;
  } else if (probResult.modelProbType == ModelProbType.decade) {
    final decadeResult = probResult as TrialProbResultEntity;
    return decadeResult.highestPercent?.toMap;
  } else if (probResult.modelProbType == ModelProbType.columns) {
    final columnResult = probResult as TrialProbResultEntity;
    return columnResult.highestPercent?.toMap;
  } else if (probResult.modelProbType == ModelProbType.terminal) {
    final terminalResult = probResult as TerminalProbResultEntity;
    return terminalResult.highestFrequencyPercent?.toMap;
  }
  return null;
}
