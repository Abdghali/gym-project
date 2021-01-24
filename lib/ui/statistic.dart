import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBDayProvider.dart';
import 'package:flutter_gym_app/Providers/DBExerciseProvider.dart';
import 'package:flutter_gym_app/Providers/exercissDetailsCounterProvider.dart';
import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/utilities/customTextStyle.dart';
import 'package:provider/provider.dart';

class Statistic extends StatefulWidget {
  @override
  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  double wight = 0.0;
  double water = 0.0;
  double burndCalorise = 0.0;
  double foodCalorise = 0.0;

  getStatisticExcercise() async {
    await context.read<DBExerciseProvider>().getAllExercises2();
    getOviralStatisticCaloriseBurnds();
    getOviralStatisticCaloriseFood();
  }

  getOviralStatisticCaloriseBurnds() async {
    List<Exercise> listEx = await context.read<DBExerciseProvider>().exercises;
    listEx.forEach((e) {
      burndCalorise += e.burnsCalories;
    });
    setState(() {});
  }

  getOviralStatisticCaloriseFood() async {
    List<Exercise> listEx = await context.read<DBExerciseProvider>().exercises;
    listEx.forEach((e) {
      foodCalorise += e.foodCalorise;
    });
    setState(() {});
  }

  getOviralWater() async {
    await context.read<DBDayProvider>().getAllDays();
    List<Day> days = await context.read<DBDayProvider>().dayes;
    days.forEach((e) {
      water += e.literOfWater;
    });
    setState(() {});
  }

  getLastWight() async {
    await context.read<DBDayProvider>().getAllDays();
    List<Day> days = await context.read<DBDayProvider>().dayes;
    wight = days.last.weight;
  }

  @override
  void initState() {
    getStatisticExcercise();
    getOviralWater();
    getLastWight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('Overal statistic',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("last Wight :  ",style: CustomTextStyle.getcustomeBouldStyle(),), Text("$wight",style: CustomTextStyle.getcustomeNormalStyle())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Water : ",style: CustomTextStyle.getcustomeBouldStyle()), Text("$water",style: CustomTextStyle.getcustomeNormalStyle())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Burnd Clorise: ",style: CustomTextStyle.getcustomeBouldStyle()), Text("$burndCalorise",style: CustomTextStyle.getcustomeNormalStyle())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Food Clorise : ",style: CustomTextStyle.getcustomeBouldStyle()), Text("$foodCalorise",style: CustomTextStyle.getcustomeNormalStyle())],
            ),
          ],
        ),
      ),
    );
  }
}
