import 'package:flutter/material.dart';

class AuthDialogoTransferencia extends StatefulWidget {
  final Function(String password) onConfirm;
  const AuthDialogoTransferencia({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<AuthDialogoTransferencia> createState() =>
      _AuthDialogoTransferenciaState();
}

class _AuthDialogoTransferenciaState extends State<AuthDialogoTransferencia> {
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Insira sua senha'),
      content: TextField(
        controller: _password,
        decoration: InputDecoration(border: OutlineInputBorder()),
        obscureText: true,
        keyboardType: TextInputType.number,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.redAccent[100]),
            )),
        OutlinedButton(
            onPressed: () {
              widget.onConfirm(_password.text);
              Navigator.pop(context);
            },
            child: Text('Confirmar'))
      ],
    );
  }
}
