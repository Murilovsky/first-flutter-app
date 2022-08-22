import 'package:bytebank/components/response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/saldo.dart';

class TelaDeposito extends StatelessWidget {
  TelaDeposito({Key? key}) : super(key: key);

  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Depositar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Valor a depositar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              inputFormatters: [],
              controller: _valorController,
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  prefix: Text('R\$  '),
                  border: OutlineInputBorder(),
                  hintText: '20.00'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _criaDeposito(context),
                      child: Text('Realizar depósito'))),
            )
          ],
        )),
      ),
    );
  }

  _criaDeposito(context) {
    final double? value = double.tryParse(_valorController.text);
    final depositoValido = _validaDeposito(value);

    if (depositoValido) {
      _atualizaEstado(context, value);
      showDialog(
              context: context,
              builder: (dialogContext) =>
                  SuccessDialog('Depósito realizado com sucesso'))
          .then((value) => Navigator.pop(context));
    } else {
      showDialog(
          context: context,
          builder: ((dialogContext) => FailureDialog('Valor inválido')));
    }
  }

  _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }

  _validaDeposito(valor) {
    final _campoPreenchido = valor != null;
    return _campoPreenchido;
  }
}
