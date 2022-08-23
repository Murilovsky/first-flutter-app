import 'dart:convert';
import 'dart:io';
import 'package:bytebank/models/transacao_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(milliseconds: 5000));

Future<List<Transacao>> findAll() async {
  final Response res =
      await client.get(Uri.http('192.168.1.181:8080', '/transactions'));
  final List<dynamic> decodedJson = jsonDecode(res.body);
  return decodedJson.map((dynamic json) => Transacao.fromJson(json)).toList();
}

Future<Transacao> salvarDados(Transacao transacao, String senha) async {
  final String transacaoJson = jsonEncode(transacao.toJson());

  await Future.delayed(const Duration(seconds: 1));

  final Response res = await client.post(
      Uri.http('192.168.1.181:8080', '/transactions'),
      headers: {'password': senha, 'Content-Type': 'application/json'},
      body: transacaoJson);

  if (res.statusCode == 200) {
    return Transacao.fromJson(jsonDecode(res.body));
  }

  throw HttpException(ErrorMessage(res.statusCode));
}

String ErrorMessage(int statusCode) {
  if (_httpError.containsKey(statusCode)) {
    return _httpError[statusCode] as String;
  }
  return 'Unknown error';
}

const Map<int, String> _httpError = {
  400: 'Erro ao enviar transação',
  401: 'Senha inválida',
  409: 'Transação já existe'
};
