import 'package:flutter/material.dart';
import 'package:flutter_gym_app/ui/exercisesDetailsPage.dart';
import 'package:flutter_gym_app/ui/indecator.dart';
import 'package:flutter_gym_app/ui/splashPage.dart';

import 'ui/homePage.dart';
import 'ui/trainingTypePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: SplashPage(),
     // home: HomePage(),
      home: TrainingTypePage(),
    // home: ExercisesDetailsPage(),
    // home: Indecator(size: 50.0,beginvalue: 0.0,endValue: 0.9,),
    );
  }
}
