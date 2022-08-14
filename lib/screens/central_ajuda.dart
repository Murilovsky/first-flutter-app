import 'package:bytebank/components/centered_message.dart';
import 'package:flutter/material.dart';

class CentralAjuda extends StatelessWidget {
  const CentralAjuda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Central de Ajuda')),
        body: MensagemCentralizada('Não tem ajuda', icon: Icons.back_hand));
  }
}
