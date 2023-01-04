// ignore_for_file: use_build_context_synchronously

import 'package:ferry_booking/pages/main_menu.dart';
import 'package:ferry_booking/pages/splashPage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import '../models/ferryticket.dart';
import '../models/user.dart';
import '../pages/displayFerryBooking.dart';
import '../pages/login_screen.dart';
import '../database/userSession.dart';

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
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE users(
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstname TEXT,
        lastname TEXT,
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
        dest_route TEXT,
        user_id INTEGER, 
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL)'''
);
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
      'users', where: 'id = ?', whereArgs: [id]);
    return User.fromMap(maps[0]);
  }

  //get user from database
  Future<List<User>> getUser() async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (index) => User.fromMap(maps[index]));
  }

  //update user
  Future<void> updateUser(User user) async {
    final db = await _ferryTicketDatabase.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.user_id],
    );
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //register user
  Future<void> registerUser(User user, BuildContext context) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [user.username],
    );
    //if user already exist, snackbar show username already exist
    if (result.isNotEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username already exist.'), 
        ),
      );
    } 
    //insert username and password int database(Replace any that already existed)
    else {
      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print(user.username);
      print(user.password);


      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully registered account')),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(title: 'title')));
    }
  }
  //////////////////////////////////////////////////////////////
  //user login
  Future<User?> userLogin(User user, BuildContext context) async {
    final db = await _ferryTicketDatabase.database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
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
        MaterialPageRoute(builder: (context) => MainMenuPage(user: user)),
      );
    }
  }
}

// ignore: camel_case_types



