import 'package:bytebank/models/contato_model.dart';
import 'package:flutter/material.dart';

import '../database/DAO/contatos_dao.dart';

class NovoContato extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _contaController = TextEditingController();

  final ContatoDAO _dao = ContatoDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Contato'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome do Contato'),
                    style: TextStyle(
                      fontSize: 24.0,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _contaController,
                  decoration: InputDecoration(labelText: 'Número da Conta'),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          final String nome = _nomeController.text;
                          final int? conta =
                              int.tryParse(_contaController.text);
                          if (nome != null && conta != null) {
                            final novoContato = Contato(0, nome, conta);
                            _dao.save(novoContato)
                                .then((id) => Navigator.pop(context));
                          }
                        },
                        child: Text('Adicionar'))),
              )
            ])));
  }
}
