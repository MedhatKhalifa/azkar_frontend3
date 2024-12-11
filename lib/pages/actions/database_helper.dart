import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('form_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE form_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        subcategory TEXT,
        done INTEGER,
        comment TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertFormEntry(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('form_data', data);
  }

  Future<List<Map<String, dynamic>>> fetchFormData(String date) async {
    final db = await instance.database;
    return await db.query(
      'form_data',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<int> updateFormEntry(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.update(
      'form_data',
      data,
      where: 'category = ? AND subcategory = ? AND date = ?',
      whereArgs: [data['category'], data['subcategory'], data['date']],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
