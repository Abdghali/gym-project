
import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBExerciseProvider.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class TestPage1 extends StatefulWidget {

  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Center(child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
RaisedButton(onPressed:()async{
   await context.read<DBExerciseProvider>().getAllExercises(1);

print(await context.read<DBExerciseProvider>().exercises[0].foodCalorise);

},child: Text("get Data"),),
RaisedButton(onPressed:()async{

Exercise ex =  Exercise(
  id: 1,
          trainingName: "Chest",
          day_id: 1,
          done: 1,
          burnsCalories: 1.0,
          foodCalorise: 1.0,
          reachedNumber: 1,
          targetNumber: 1);
      await context.read<DBExerciseProvider>().insertIntoDatabase(ex);

},child: Text("insert Data"),),

],)),

    );
  }
}