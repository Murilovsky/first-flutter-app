class Contato {
  final String nome;
  final int? conta;
  final int id;

  Contato(this.id, this.nome, this.conta);

  @override
  String toString() {
    return 'Contato{id:$id nome: $nome, conta: $conta}';
  }
}
