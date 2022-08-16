import 'package:bytebank/models/contato_model.dart';

class Transacao {
  final double value;
  final Contato contato;

  Transacao(
    this.value,
    this.contato,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contato}';
  }

  Transacao.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': value,
        'contact': contato.toJson(),
      };
}
