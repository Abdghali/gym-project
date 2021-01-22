import 'package:flutter/cupertino.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/services/DBExerciseHelper.dart';

class DBExerciseProvider extends ChangeNotifier {
  List<Exercise> exercises = [];

 fillList(List<Exercise> _exercise) {
    this.exercises = _exercise;
    notifyListeners();
  }

  insertIntoDatabase(Exercise exercise) async {
    await DBExerciseHelper.dbexerciseHelper.insertInToDatabase(exercise);
    getAllDays();
  }
  getAllDays() async {
    List<Map<String, dynamic>> rows =
        await DBExerciseHelper.dbexerciseHelper.getAllexerciseDataFromDatabase();
    List<Exercise> listOfexcersise = rows.map((e) => Exercise.fromMap(e)).toList();
    fillList(listOfexcersise);
  }

updateDay(Exercise exercise) async {
    await  DBExerciseHelper.dbexerciseHelper.updateDataInDatabase(exercise);
    getAllDays();
  }

 deleteDay(Exercise exercise) async {
   await DBExerciseHelper.dbexerciseHelper.deleteOneExerciseFromDatabase(exercise.id);
    getAllDays();
  }

}