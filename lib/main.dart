import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
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
            button: TextStyle(fontSize: 24)),
        primarySwatch: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: Dashboard(),
    );
  }
}
