import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
    static final _dbNome = "meus_contatos.db";
    static final _dbVersion = 1;

    static Database? _db;
    static final DB instance = DB._privateConstructor();

    DB._privateConstructor();

    Future<Database> get database async {
      if (_db != null) {
        return _db!;
      }

      _db = await _initDatabase();
      return _db!;
    }

    Future<Database> _initDatabase() async {
      final path = await getDatabasesPath();
      final databasePath = join(path, _dbNome);
      return await openDatabase(
        databasePath,
        version: _dbVersion,
        onCreate: _onCreate,
      );
    }

    Future<void> _onCreate(Database db, int version) async {
      await db.execute('''
      CREATE TABLE contatos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        telefone TEXT NOT NULL,
        imagem TEXT NOT NULL
      )
    ''');
    }
}