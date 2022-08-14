import 'package:sqflite/sqflite.dart';
import '../../models/contato_model.dart';
import '../database.dart';

class ContatoDAO {
  static const String tableSql = 'CREATE TABLE $_tableName('
      'id INTEGER PRIMARY KEY, '
      'nome TEXT, '
      'numero_conta INTEGER)';
  static const String _tableName = 'contatos';

  Future<int> save(Contato contato) async {
    final Database db = await GetDatabase();
    Map<String, dynamic> contatosMap = _toMap(contato);
    return db.insert(_tableName, contatosMap);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contatosMap = Map();
    contatosMap['nome'] = contato.nome;
    contatosMap['numero_conta'] = contato.conta;
    return contatosMap;
  }

  Future<List<Contato>> BuscaTodos() async {
    final Database db = await GetDatabase();
    final List<Map<String, dynamic>> resultado = await db.query(_tableName);
    List<Contato> contatos = _toList(resultado);
    return contatos;
  }

  List<Contato> _toList(List<Map<String, dynamic>> resultado) {
    final List<Contato> contatos = [];
    for (Map<String, dynamic> row in resultado) {
      final Contato contato =
          Contato(row['id'], row['nome'], row['numero_conta']);
      contatos.add(contato);
    }
    return contatos;
  }
}
