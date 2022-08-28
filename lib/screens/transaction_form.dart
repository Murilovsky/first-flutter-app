import 'package:bytebank/api/web_client.dart';
import 'package:bytebank/components/dialogo_transacao.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/models/contato_model.dart';
import 'package:bytebank/models/transacao_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/saldo.dart';

class FormularioTransacao extends StatefulWidget {
  final Contato contato;

  FormularioTransacao(this.contato);

  @override
  State<FormularioTransacao> createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final TextEditingController _valueController = TextEditingController();
  final String transacaoID = const Uuid().v4();
  bool _enviando = false;
  bool _saldoIns = false;
  bool isButtonDisabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nova Transação'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                        visible: _enviando,
                        child: const Progresso('Processando transferência')),
                    Text(
                      widget.contato.nome,
                      style: const TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        widget.contato.conta.toString(),
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextField(
                        controller: _valueController,
                        onChanged: _verificaValor,
                        style: const TextStyle(fontSize: 24.0),
                        decoration: const InputDecoration(labelText: 'Valor'),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Visibility(
                        visible: _saldoIns,
                        child: Text(
                          'Saldo insuficiente',
                          style:
                              TextStyle(color: Colors.red[300], fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                              onPressed: isButtonDisabled
                                  ? null
                                  : () {
                                      final double value =
                                          double.parse(_valueController.text);
                                      final transactionCreated = Transacao(
                                          transacaoID, value, widget.contato);

                                      showDialog(
                                          context: context,
                                          builder: (contextDialog) {
                                            return AuthDialogoTransferencia(
                                              onConfirm: _salvarDados(
                                                  transactionCreated, context),
                                            );
                                          });
                                    },
                              child: const Text('Transferir'))),
                    )
                  ],
                ))));
  }

  void _verificaValor(value) {
    final check = double.tryParse(value);
    if (check != null && check > 0) {
      if (Provider.of<Saldo>(context, listen: false).valor >= check) {
        setState(() {
          _saldoIns = false;
          isButtonDisabled = false;
        });
      } else {
        setState(() {
          _saldoIns = true;
          isButtonDisabled = true;
        });
      }
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }
  }

  _salvarDados(Transacao transactionCreated, BuildContext context) {
    return ((password) {
      setState(() {
        _enviando = true;
      });
      salvarDados(transactionCreated, password).catchError((erro) {
        FirebaseCrashlytics.instance.recordError(erro.message, null);
        showDialog(
            context: context,
            builder: (contextDialog) {
              return FailureDialog('Não foi possível realizar a transação');
            });
      }).then((trans) {
        Provider.of<Saldo>(context, listen: false).gasta(trans.value);
        showDialog(
            context: context,
            builder: (contextDialog) {
              return SuccessDialog('Transferência Realizada');
            }).then((value) => Navigator.pop(context));
      }).catchError((erro) {
        FirebaseCrashlytics.instance.recordError(erro.message, null);
        showDialog(
            context: context,
            builder: (contextDialog) {
              return FailureDialog(erro.message);
            });
      }).whenComplete(() {
        setState(() {
          _enviando = false;
        });
      });
    });
  }
}
