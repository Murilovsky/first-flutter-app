import 'package:bytebank/api/web_client.dart';
import 'package:bytebank/models/contato_model.dart';
import 'package:bytebank/models/transacao_model.dart';
import 'package:flutter/material.dart';

class FormularioTransacao extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final Contato contato;

  FormularioTransacao(this.contato);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nova Transação'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contato.nome,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        contato.conta.toString(),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextField(
                        controller: _valueController,
                        style: TextStyle(fontSize: 24.0),
                        decoration: InputDecoration(labelText: 'Valor'),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                              child: Text('Transferir'),
                              onPressed: () {
                                final double value =
                                    double.tryParse(_valueController.text)
                                        as double;
                                final transactionCreated =
                                    Transacao(value, contato);
                                salvarDados(transactionCreated).then((trans) {
                                  if (trans != null) {
                                    Navigator.pop(context);
                                  }
                                });
                              })),
                    )
                  ],
                ))));
  }
}
