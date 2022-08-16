import 'dart:convert';
import 'package:bytebank/models/transacao_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: Duration(milliseconds: 500));

Future<List<Transacao>> findAll() async {
  final Response res =
      await client.get(Uri.http('192.168.1.181:8080', '/transactions'));
  final List<dynamic> decodedJson = jsonDecode(res.body);
  return decodedJson.map((dynamic json) => Transacao.fromJson(json)).toList();
}

Future<Transacao> salvarDados(Transacao transacao, String senha) async {
  final String transacaoJson = jsonEncode(transacao.toJson());

  await Future.delayed(Duration(seconds: 10));

  final Response res = await client.post(
      Uri.http('192.168.1.181:8080', '/transactions'),
      headers: {'password': senha, 'Content-Type': 'application/json'},
      body: transacaoJson);

  if (res.statusCode != 200) {
    _httpError(res.statusCode);
  }

  return Transacao.fromJson(jsonDecode(res.body));
}

void _httpError(int statusCode) {
  if (statusCode == 401) {
    throw Exception("Senha inválida");
  }
}
