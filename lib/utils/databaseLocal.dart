import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "my_database.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE biodata_diri (
        id INTEGER PRIMARY KEY,
        name TEXT,
        dateOfBirth TEXT,
        gender TEXT,
        email TEXT,
        phone TEXT,
        education TEXT,
        maritalStatus TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE address (
        id INTEGER PRIMARY KEY,
        province TEXT,
        regency TEXT,
        district TEXT,
        village TEXT,
        addressDetail TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE informasi_perusahaan (
        id INTEGER PRIMARY KEY,
        company_name TEXT,
        company_address TEXT,
        bank_branch TEXT,
        account_number TEXT,
        account_owner TEXT,
        jabatan TEXT,
        lama_bekerja TEXT,
        sumber_pendapatan TEXT,
        pendapatan_per_tahun TEXT,
        bank TEXT
      )
    ''');
  }

  Future<int> insertBiodataDiri(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('biodata_diri', row);
  }

  Future<List<Map<String, dynamic>>> queryAllBiodataDiri() async {
    Database db = await instance.database;
    return await db.query('biodata_diri');
  }

  Future<int> insertAddress(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('address', row);
  }

  Future<List<Map<String, dynamic>>> queryAllAddress() async {
    Database db = await instance.database;
    return await db.query('address');
  }

  Future<int> insertInformasiPerusahaan(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('informasi_perusahaan', row);
  }

  Future<List<Map<String, dynamic>>> queryAllInformasiPerusahaan() async {
    Database db = await instance.database;
    return await db.query('informasi_perusahaan');
  }

  Future<int> deleteData(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateData(String table, Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }
}
