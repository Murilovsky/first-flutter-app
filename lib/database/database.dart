import 'dart:async';
import 'package:bytebank/database/DAO/contatos_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> GetDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContatoDAO.tableSql);
  }, version: 1);
}
