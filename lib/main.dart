import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Saldo(2000),
    child: ByteBankApp(),
  ));
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 24.0),
            button: TextStyle(fontSize: 16)),
        primarySwatch: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: Dashboard(),
    );
  }
}
