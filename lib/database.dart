import 'dart:io';
import 'package:alarm_project/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'alarms.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE alarms(id INTEGER PRIMARY KEY AUTOINCREMENT, label TEXT, time TEXT)',
        );
      },
    );
  }

  Future<int> insertAlarm(Alarm alarm) async {
    Database db = await database;
    return await db.insert('alarms', alarm.toMap());
  }

  Future<List<Alarm>> getAlarms() async {
    Database db = await database;
    var res = await db.query('alarms');
    List<Alarm> list = res.isNotEmpty
        ? res.map((c) => Alarm.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<int> updateAlarm(Alarm alarm) async {
    Database db = await database;
    return await db.update(
      'alarms',
      alarm.toMap(),
      where: 'id = ?',
      whereArgs: [alarm.id],
    );
  }

  Future<int> deleteAlarm(int id) async {
    Database db = await database;
    return await db.delete(
      'alarms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
