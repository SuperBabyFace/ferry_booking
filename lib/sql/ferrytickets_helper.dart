import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ferryticket.dart';

class FerryTicketDatabase {
  static final FerryTicketDatabase _ferryTicketDatabase = FerryTicketDatabase._internal();
  factory FerryTicketDatabase() => _ferryTicketDatabase;
  FerryTicketDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'waterspace.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON')
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE users(
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        f_name TEXT,
        l_name TEXT,
        username TEXT,
        password TEXT,
        mobilehp TEXT)'''
    );
    await db.execute(
      '''CREATE TABLE ferryTicket(
        book_id INTEGER PRIMARY KEY AUTOINCREMENT,
        depart_date TEXT,
        journey TEXT,
        depart_route TEXT,
        user_id INTEGER, 
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL''');
  }

  Future<void> insertFerryTicket(FerryTicket ferryTicket) async {
    final db = await _ferryTicketDatabase.database;
    await db.insert('ferryTicket', ferryTicket.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    print(ferryTicket);
  }

  Future<List<FerryTicket>> getFerryUserTicket(int user_id) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ferryTicket', where: 'user_id = ?', whereArgs: [user_id]
    );
    return List.generate(
      maps.length, (index) => FerryTicket.fromMap(maps[index])
    );
  }

  Future <void> editFerryTicket(FerryTicket ferryTicket) async {
    final db = await _ferryTicketDatabase.database;
    await db.update(
      'ferryTicket',
      ferryTicket.toMap(),
      where: 'book_id = ?',
      whereArgs: [ferryTicket.book_id]
    );
  }



}