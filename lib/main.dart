import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBDayProvider.dart';
import 'package:flutter_gym_app/Providers/DBExerciseProvider.dart';
import 'package:flutter_gym_app/Providers/trainingPageCounter.dart';
import 'package:flutter_gym_app/services/DBExerciseHelper.dart';
import 'package:flutter_gym_app/services/DBHelper.dart';
import 'package:flutter_gym_app/ui/homePage.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_gym_app/ui/testPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await DBDayHelper.dbDayHelper.initDatabase();
   await DBExerciseHelper.dbexerciseHelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
  providers: [
      ChangeNotifierProvider<DBDayProvider>(
        create: (_) => DBDayProvider(),
      ),
      ChangeNotifierProvider<DBExerciseProvider>(
        create: (_) => DBExerciseProvider(),
      ),
      ChangeNotifierProvider<TainingPageCounterProvider>(
              create: (_) => TainingPageCounterProvider(),
            ),
        ],
          child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
           // home: SplashPage(),
           home: HomePage(),
          // home: TrainingTypePage(),
          // home: ReportPage(),
          // home: ExercisesDetailsPage(),
          // home: Indecator(size: 50.0,beginvalue: 0.0,endValue: 0.9,),
          //home: TestPage1(),
          ));
        }
      }
      
  