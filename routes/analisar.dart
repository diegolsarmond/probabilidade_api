import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../src/domain/entities/_entities.dart';
import '../src/enums/_enums.dart';
import '../src/models/_models.dart';
import '../src/usecases/_usecases.dart';

Future<Response> onRequest(RequestContext context) async {
  // try {
  // Obter o corpo da requisição como uma string
  final body = await context.request.body();
  // Parsear o corpo da requisição para uma lista de inteiros
  var data = jsonDecode(body);

  // Garantir que os dados sejam uma lista de inteiros
  var numbers = List<int>.from(
    (data['numeros'] as List).map((e) {
      return e is int ? e : 0;
    }),
  ).reversed.toList();

  var x = TerminalProbUseCase(
    history: numbers.map((e) => NumberItem(number: e)).toList(),
    limit: data['limiteNumeros'] as int,
    minProbability: data['minimoPorcento'] as int,
  ).analyze(ModelProbType.colors);

  return Response.json(
    body: {
      'porcentagem': x.highestFrequencyPercent!.frequencyPercent,
      'sugestao': x.highestFrequencyPercent!.suggestion?.terminalType.terminal,
      'media': x.highestFrequencyPercent!.median,
    },
  );
  // } catch (e) {
  //
  //   Caso ocorra algum erro, retornar um erro 400 com a mensagem
  // return Response.json(body: {'error': 'Invalid input'}, statusCode: 400);
  // }
}
