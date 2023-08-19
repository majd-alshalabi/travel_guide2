import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettAlKolDatabase {
  static final SettAlKolDatabase _instance = SettAlKolDatabase.internal();

  factory SettAlKolDatabase() => _instance;

  SettAlKolDatabase.internal();

  // Users
  static const kIdentity = "myIdentity";

  static Database? _db;

  int _versionDb = 1;

  int get versionDb => _versionDb;

  //short setter for my variable
  set versionDb(int? value) => _versionDb = value!;

  Future<Database> initDB() async {
    if (_db != null) {
      return _db!;
    }
    String path = join(await getDatabasesPath(), "e3lanaty.db");
    _db = await openDatabase(path,
        version: versionDb,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure);
    return _db!;
  }

  deleteMyDatabase() async {
    await deleteDatabase(join(await getDatabasesPath(), "e3lanaty.db"));
    _db = null;
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    // If you need to add a column
    if (newVersion > oldVersion) {
      db.execute("ALTER TABLE foo ADD COLUMN new_column INTEGER DEFAULT 0");
    }
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("create table $kIdentity(id integer primary key ,"
        "phoneNumber TEXT,name TEXT,"
        "imageUrl TEXT,token TEXT,serverId integer,guide integer,notificationType integer,"
        "fcmToken TEXT,location TEXT ,"
        "email TEXT,createdAt TEXT "
        ")");
  }
}
