import 'dart:convert';

import 'package:bytebank/models/contato_model.dart';
import 'package:bytebank/models/transacao_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

Future<List<Transacao>> findAll() async {
  final Response res = await client
      .get(Uri.http('192.168.1.181:8080', '/transactions'))
      .timeout(const Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(res.body);
  final List<Transacao> transacoes = [];
  for (Map<String, dynamic> elemento in decodedJson) {
    final Transacao transacao = Transacao(
        elemento['value'],
        Contato(0, elemento['contact']['name'],
            elemento['contact']['accountNumber']));
    transacoes.add(transacao);
  }
  return transacoes;
}

Future<Transacao> salvarDados(Transacao transacao) async {
  final Map<String, dynamic> transacaoMap = {
    'value': transacao.value,
    'contact': {
      'name': transacao.contato.nome,
      'accountNumber': transacao.contato.conta
    }
  };
  final String transacaoJson = jsonEncode(transacaoMap);

  final Response res = await client.post(
      Uri.http('192.168.1.181:8080', '/transactions'),
      headers: {'password': '1000', 'Content-Type': 'application/json'},
      body: transacaoJson);

  Map<String, dynamic> json = jsonDecode(res.body);
  return Transacao(json['value'],
      Contato(0, json['contact']['name'], json['contact']['accountNumber']));
}
