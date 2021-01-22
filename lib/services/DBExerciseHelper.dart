import 'dart:io';

import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBExerciseHelper {
  DBExerciseHelper._();
  static DBExerciseHelper dbexerciseHelper = DBExerciseHelper._();
  static String id ='id';
  static String day_id='day_id';
  static String trainingNam="trainingName";
  static String targetNumber="targetNumber";
  static String reachedNumber="reachedNumber";
  static String foodCalorise="foodCalorise";
  static String burnsCalories="burnsCalories";
  static String done="done";
  static String exercisetable = 'exercisetable';

  Database database;

  initDatabase() async {
    if (database == null) {
      database = await connectToDatabase();
    }
  }

  Future<Database> connectToDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path; // get
    String databasePath = join(appDocPath, 'gym.db'); // to create db path
    Database database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      createTable(db);
    }); // to connect to database if its estableshed else will be create new one and return connection to DB
    return database;
  }

  createTable(Database db) {
    db.execute(
        '''CREATE TABLE $exercisetable (id INTEGER PRIMARY KEY AUTOINCREMENT,
        $day_id INTEGER ,
        $trainingNam TEXT NOT NULL,
        $targetNumber INTEGER,
        $reachedNumber INTEGER,
        $foodCalorise Double,
        $burnsCalories Double,
        $done INTEGER)''');
  }

  insertInToDatabase(Exercise exercise) async {
    try {
      int rowIndex = await database.insert(exercisetable, exercise.toMap());
      print(rowIndex);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllexerciseDataFromDatabase() async {
    try {
      List<Map<String, dynamic>> allexercise = await database.query(exercisetable);
      return allexercise;
    } on Exception catch (e) {
      print(e);
    }
  }

  getOneexerciseFromDatabase(int allexerciseId) async {
    try {
      List<Map<String, dynamic>> listResult = await database.query(exercisetable,
          where: '$id=?',
          whereArgs: [allexerciseId],
          // columns: [name, age, gender],
          distinct: true,
          limit: 1);
      Map<String, dynamic> result =
          listResult != null ? listResult.first : null;
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteOneExerciseFromDatabase(int allexerciseId) {
    database.delete(exercisetable, where: 'id=?', whereArgs: [allexerciseId]);
  }

  updateDataInDatabase(Exercise exercise) {
    database.update(exercisetable, exercise.toMap(), where: 'id=?', whereArgs: [exercise.id]);
  }

  deleteAllFromDatabase() {
    database.delete(exercisetable);
  }
}
