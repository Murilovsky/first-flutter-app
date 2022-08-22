import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Saldo>(builder: (context, valor, child) {
          return Text(valor.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold));
        }),
      ),
    );
  }
}
