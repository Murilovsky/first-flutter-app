import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/contato_model.dart';
import 'package:bytebank/screens/novo_contato.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

import '../database/DAO/contatos_dao.dart';

class ContatosLista extends StatefulWidget {
  @override
  State<ContatosLista> createState() => _ContatosListaState();
}

class _ContatosListaState extends State<ContatosLista> {
  final List<Contato> contatos = [];
  final ContatoDAO _dao = ContatoDAO();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: [],
        future: _dao.BuscaTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              Text('Nenhum contato salvo', style: TextStyle(fontSize: 32));
              break;
            case ConnectionState.waiting:
              return Progresso(message: 'Carregando contatos');

            case ConnectionState.active:
              return Text('');

            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data!;
              return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contato contato = contatos[index];
                    return CardContato(
                      contato,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                FormularioTransacao(contato)));
                      },
                    );
                  },
                  itemCount: contatos.length);
          }
          return Text('');
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NovoContato()))
                .then((value) {
              setState(() {
                widget.createState();
              });
            });
          },
          child: Icon(Icons.add)),
    );
  }
}

class CardContato extends StatelessWidget {
  final Contato contato;
  final Function onTap;

  CardContato(this.contato, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () => onTap(),
          title: Text(contato.nome, style: TextStyle(fontSize: 24)),
          subtitle:
              (Text(contato.conta.toString(), style: TextStyle(fontSize: 16)))),
    );
  }
}
