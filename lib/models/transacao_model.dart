import 'package:bytebank/models/contato_model.dart';

class Transacao {
  final String id;
  final double value;
  final Contato contato;

  Transacao(
    this.id,
    this.value,
    this.contato,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contato}';
  }

  Transacao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'contact': contato.toJson(),
      };
}
