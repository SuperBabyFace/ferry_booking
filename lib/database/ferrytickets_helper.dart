import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

  //insert ferry ticket onto database. 
  //conflictalgorithm replace an duplicates
  Future<void> insertFerryTicket(FerryTicket ferryTicket) async {
    final db = await _ferryTicketDatabase.database;
    await db.insert('ferryTicket', ferryTicket.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    print(ferryTicket);
  }

  //get ferry ticket base on user's id
  Future<List<FerryTicket>> getFerryUserTicket(int user_id) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ferryTicket', where: 'user_id = ?', whereArgs: [user_id]
    );
    return List.generate(
      maps.length, (index) => FerryTicket.fromMap(maps[index])
    );
  }

  //edit ferry ticket
  Future <void> editFerryTicket(FerryTicket ferryTicket) async {
    final db = await _ferryTicketDatabase.database;
    await db.update(
      'ferryTicket',
      ferryTicket.toMap(),
      where: 'book_id = ?',
      whereArgs: [ferryTicket.book_id]
    );
  }

  Future<void> deleteFerryTicket(int id) async {
    final db = await _ferryTicketDatabase.database;
    await db.delete(
      'ferryTicket', where: 'book_id = ?', whereArgs: [id]
    );
  }

  //USER NEED MODEL
  //USER METHODS
  Future<User> user(int id) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user', where: 'id = ?', whereArgs: [id]);
    return User.fromMap(maps[0]);
  }

  //get user from database
  Future<List<User>> getUser() async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    return List.generate(maps.length, (index) => User.fromMap(maps[index]));
  }

  //update user
  Future<void> updateUser(User user) async {
    final db = await _ferryTicketDatabase.database;
    await db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.user_id],
    );
  }

  //register user
  Future<void> registerUser(User user, BuildContext context) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [user.username],
    );
    //if user already exist, snackbar show username already exist
    if (result.isNotEmpty) {
<<<<<<< Updated upstream
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username already exist.'), 
        duration: Duration(seconds: 5),
        ),
      );
=======
      Widget okButton = TextButton(onPressed:(){}, child: Text('OK'));
      AlertDialog alert = AlertDialog(
        title: Text('Registration Unsucessful.'),
        content: Text('Username already exist. Please pick another.'),
        actions: [okButton],
      );
      showDialog(context: context, builder: (BuildContext context) {
        return alert;
      });
>>>>>>> Stashed changes
    } 
    //insert username and password int database(Replace any that already existed)
    else {
      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print(user.username);
      print(user.password);

<<<<<<< Updated upstream
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully registered account')),
      );
=======
      Widget okButton = TextButton(onPressed:(){}, child: Text('OK'));
      AlertDialog alert = AlertDialog(
        title: Text('Registration Sucessful.'),
        content: Text('Your account has been created.'),
        actions: [okButton],
      );
      showDialog(context: context, builder: (BuildContext context) {
        return alert;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Successfully registered account')),
      // );
>>>>>>> Stashed changes
      Navigator.pop(context);
    }
  }

  Future<User?> userLogin(User user, BuildContext context) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ? and password = ?',
      whereArgs: [user.username, user.password],
    );
    print(user);
    if (result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Wrong password or username. Log in unsuccessful.')),
      );
    } else {
      int id = result[0]["user_id"];
      await userSaveSession.setCurrentUserId(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful. Welcome, ${user.username}.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => /*HomePage*/(user: user)),
      );
    }
  }
}

class userSaveSession {
  static SharedPreferences? _preferences;
  static const _currentUserId = "currentUserId";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setCurrentUserId(int user_id) async =>
      await _preferences!.setInt(_currentUserId, user_id);

<<<<<<< Updated upstream
  static int? getCurrentUserId() => _preferences!.getInt(_currentUserId);
=======
  static int? getUserID() => _preferences!.getInt(_currentUserId);
>>>>>>> Stashed changes
}



