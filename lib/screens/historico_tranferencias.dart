import 'package:bytebank/api/web_client.dart';
import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/transacao_model.dart';
import 'package:flutter/material.dart';

class TransferenciasLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Transferências'),
        ),
        body: FutureBuilder<List<Transacao>>(
            initialData: [],
            future: findAll(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;

                case ConnectionState.waiting:
                  return Progresso('Carregando Transferências');

                case ConnectionState.active:
                  break;

                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final List<Transacao> transacoes = snapshot.data!;
                    if (transacoes.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final Transacao transacao = transacoes[index];
                          return Card(
                              child: ListTile(
                                  leading: Icon(Icons.monetization_on),
                                  title: Text(
                                    transacao.value.toString(),
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle:
                                      Text(transacao.contato.conta.toString(),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ))));
                        },
                        itemCount: transacoes.length,
                      );
                    }
                    return MensagemCentralizada('Não há transferências',
                        icon: Icons.warning);
                  }
              }
              return MensagemCentralizada('Unknown Error');
            })));
  }
}
