class Contato {
  final String nome;
  final int? conta;

  Contato(this.nome, this.conta);

  @override
  String toString() {
    return 'Contato{nome: $nome, conta: $conta}';
  }

  Contato.fromJson(Map<String, dynamic> json)
      : nome = json['name'],
        conta = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': nome,
        'accountNumber': conta,
      };
}
