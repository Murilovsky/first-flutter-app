import 'package:flutter/material.dart';

class Progresso extends StatelessWidget {
  const Progresso({Key? key, String? message}) : super(key: key);

  final String message = '';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          CircularProgressIndicator(strokeWidth: 6),
          Text(message,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
        ]));
  }
}
