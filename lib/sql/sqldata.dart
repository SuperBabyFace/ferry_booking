import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLData {
  static get createAt => null;

  static Future<void> createTables(sql.Database database_ticket) async {
    await database_ticket.execute(""" 
      CREATE TABLE users (
        user_id INTEGER(5) PRIMARY KEY AUTOINCREMENT NOT NULL,
        f_name VARCHAR(50) NOT NULL,
        l_name VARCHAR(50) NOT NULL,
        username VARCHAR(20) NOT NULL,
        password VARCHAR(20) NOT NULL,
        mobilehp INTEGER(11) NOT NULL,
      )    
    """);

    await database_ticket.execute('''
      CREATE TABLE ferryServices (
        departure VARCHAR(20),
        destination VARCHAR(20),
      )
''');

    await database_ticket.execute('''
      CREATE TABLE ferryTicket (
        book_id INTEGER(5) PRIMARY KEY AUTOINCREMENT NOT NULL,
        depart_date DATE NOT NULL,
        journey VARCHAR(10) NOT NULL,
        depart_route VARCHAR(20) NOT NULL,
        dest_route VARCHAR(20) NOT NULL,
        FOREIGN KEY (userid) REFERENCES users(user_id) ON DELETE SET NULL,
      )
''');
  }
}
