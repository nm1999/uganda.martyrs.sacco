import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ugandamartyrssacco.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstname TEXT NOT NULL,
        surname TEXT NOT NULL,
        address TEXT,
        phone TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE savings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        member_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (member_id) REFERENCES members (id)
      )
    ''');
  }

  // Insert a new member
  Future<int> insertMember(String firstname,String surname, String address, String phone) async {
    final db = await database;
    return await db.insert('members', {
      'firstname': firstname,
      'surname': surname,
      'address': address,
      'phone': phone
    });
  }

  // Read all members
  Future<List<Map<String, dynamic>>> getMembers() async {
    final db = await database;
    return await db.query('members');
  }

  // Insert a new savings record
  Future<int> insertSavings(int memberId, double amount, String date) async {
    final db = await database;
    return await db.insert('savings', {
      'member_id': memberId,
      'amount': amount,
      'date': date,
    });
  }

  // Read all savings records
  Future<List<Map<String, dynamic>>> getSavings() async {
    final db = await database;
    return await db.query('savings');
  }

  // Read savings for a specific member
  Future<List<Map<String, dynamic>>> getSavingsByMember(int memberId) async {
    final db = await database;
    return await db.query('savings', where: 'member_id = ?', whereArgs: [memberId]);
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
