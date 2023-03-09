import 'package:agenda_contatos/Database/db.dart';
import 'package:agenda_contatos/models/contato.dart';

class ContatoDao {
  final _db = DB.instance;

  Future<int> criar(Contato contato) async {
    final db = await _db.database;
    return await db.insert("contatos", contato.toMap());
  }

  Future<List<Contato>> listar() async {
    final db = await _db.database;
    final result = await db.query("contatos");
    return result.map((json) => Contato.fromMap(json)).toList();
  }

  Future<int> atualizar(Contato contato) async {
    final db = await _db.database;
    return await db.update(
      "contatos",
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<int> excluir(int id) async {
    final db = await _db.database;
    return await db.delete(
      "contatos",
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}