import 'dart:async';
import 'dart:io';
import 'package:city_travel_guide/model/Categories.dart';
import 'package:city_travel_guide/model/Country.dart';
import 'package:city_travel_guide/model/City.dart';
import 'package:city_travel_guide/model/HistoricalPlaces.dart';
import 'package:city_travel_guide/model/Hospital.dart';
import 'package:city_travel_guide/model/Parks.dart';
import 'package:city_travel_guide/model/Police.dart';
import 'package:city_travel_guide/model/Restaurants.dart';
import 'package:city_travel_guide/model/Mall.dart';
import 'package:city_travel_guide/pages/deneme/comment.dart';
import 'package:city_travel_guide/model/Town.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class DbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, 'app.db');

    /*    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
    ByteData data = await rootBundle.load(join("assets", "citytravelguide.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true); */
    // open the database
    return await openDatabase(path);
  }

  Future<List<Countries>> getCountries() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM Country");
    return result.map((data) => Countries.fromMap(data)).toList();
  }

  Future<List<City>> getCities(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM City WHERE country_id = $id ORDER BY city_name ASC");
    return result.map((data) => City.fromMap(data)).toList();
  }

  Future<List<Town>> getTowns(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM Town WHERE city_id = $id ORDER BY town_name ASC");
    return result.map((data) => Town.fromMap(data)).toList();
  }

  Future<List<Categories>> getCategories(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM Categories WHERE town_id = $id ORDER BY categories_name ASC");
    return result.map((data) => Categories.fromMap(data)).toList();
  }

  Future<List<HistoricalPlaces>> getHist(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM HistoricalPlaces WHERE categories_id = $id ORDER BY hist_name ASC");
    return result.map((data) => HistoricalPlaces.fromMap(data)).toList();
  }

  Future<List<Hospital>> getHospital(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM Hospital WHERE categories_id = $id ORDER BY hospital_name ASC");
    return result.map((data) => Hospital.fromMap(data)).toList();
  }

  Future<List<Parks>> getPark(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM Parks WHERE categories_id = $id ORDER BY park_name ASC");
    return result.map((data) => Parks.fromMap(data)).toList();
  }

  Future<List<Police>> getPolice(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM Police WHERE categories_id = $id ORDER BY station_name ASC");
    return result.map((data) => Police.fromMap(data)).toList();
  }

  Future<List<Restaurants>> getRest(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM Restaurants WHERE categories_id = $id ORDER BY restaurant_name ASC");
    return result.map((data) => Restaurants.fromMap(data)).toList();
  }

  Future<List<Mall>> getMall(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM ShoppingMalls WHERE categories_id = $id ORDER BY mall_name ASC");
    return result.map((data) => Mall.fromMap(data)).toList();
  }

  Future<List<Comments>> getComments() async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM Comments ORDER BY userName ASC");
    return result.map((data) => Comments.fromMap(data)).toList();
  }

  Future<int> insertComment(Comments comments) async {
    var dbClient = await db;
    return await dbClient.insert("Comments", comments.toMap());
  }

  Future<int> updateComment(Comments comments) async {
    var dbClient = await db;
    return await dbClient.update("Comments", comments.toMap(),
        where: "id=?", whereArgs: [comments.id]);
  }

  Future<int> removeComment(int id) async {
    var dbClient = await db;
    return await dbClient.delete("Comments", where: "id=?", whereArgs: [id]);
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}
