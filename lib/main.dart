import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(ChangeNotifierProvider(
    create: (context) => Saldo(0),
    child: const ByteBankApp(),
  ));
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyText1: TextStyle(fontSize: 24.0),
            button: TextStyle(fontSize: 16)),
        primarySwatch: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const Dashboard(),
    );
  }
}
