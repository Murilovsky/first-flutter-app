import 'package:bytebank/api/web_client.dart';
import 'package:bytebank/components/dialogo_transacao.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/models/contato_model.dart';
import 'package:bytebank/models/transacao_model.dart';
import 'package:flutter/material.dart';

class FormularioTransacao extends StatefulWidget {
  final Contato contato;

  FormularioTransacao(this.contato);

  @override
  State<FormularioTransacao> createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final TextEditingController _valueController = TextEditingController();
  bool isButtonDisabled = true;
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
                      widget.contato.nome,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        widget.contato.conta.toString(),
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
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              isButtonDisabled = false;
                            });
                          } else {
                            setState(() {
                              isButtonDisabled = true;
                            });
                          }
                        },
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
                              onPressed: isButtonDisabled
                                  ? null
                                  : () {
                                      final double value =
                                          double.tryParse(_valueController.text)
                                              as double;
                                      final transactionCreated =
                                          Transacao(value, widget.contato);

                                      showDialog(
                                          context: context,
                                          builder: (contextDialog) {
                                            return AuthDialogoTransferencia(
                                              onConfirm: _SalvarDados(
                                                  transactionCreated, context),
                                            );
                                          });
                                    })),
                    )
                  ],
                ))));
  }

  _SalvarDados(Transacao transactionCreated, BuildContext context) {
    return ((password) =>
        salvarDados(transactionCreated, password).catchError((erro) {
          showDialog(
              context: context,
              builder: (contextDialog) {
                return FailureDialog('Não foi possível realizar a transação');
              });
        }).then((trans) {
          if (trans != null) {
            showDialog(
                context: context,
                builder: (contextDialog) {
                  return SuccessDialog('Transferência Realizada');
                }).then((value) => Navigator.pop(context));
          }
        }).catchError((erro) {
          showDialog(
              context: context,
              builder: (contextDialog) {
                return FailureDialog(erro.message);
              });
        }));
  }
}
