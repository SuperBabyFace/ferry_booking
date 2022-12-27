import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLData {
  static get createAt => null;

  static Future<void> createTables(sql.Database database_ticket) async {
    await database_ticket.execute(""" 
      CREATE TABLE users (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        f_name TEXT NOT NULL,
        l_name TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        mobilehp INTEGER NOT NULL,
      )    
    """);

    await database_ticket.execute('''
      CREATE TABLE ferryServices (
        departure TEXT,
        destination TEXT,
      )
''');

    await database_ticket.execute('''
      CREATE TABLE ferryTicket (
        book_id INTEGER(5) PRIMARY KEY AUTOINCREMENT NOT NULL,
        depart_date DATE NOT NULL,
        journey TEXT NOT NULL,
        depart_route TEXT NOT NULL,
        dest_route TEXT NOT NULL,
        FOREIGN KEY (userid) REFERENCES users(user_id) ON DELETE SET NULL,
      )
''');
  }
}
