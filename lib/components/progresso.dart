import 'package:flutter/material.dart';

class Progresso extends StatelessWidget {
  const Progresso(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          CircularProgressIndicator(strokeWidth: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900])),
          )
        ]));
  }
}
