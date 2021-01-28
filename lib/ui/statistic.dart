import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBDayProvider.dart';
import 'package:flutter_gym_app/Providers/DBExerciseProvider.dart';
import 'package:flutter_gym_app/Providers/chartProvider.dart';
import 'package:flutter_gym_app/models/ChartItem.dart';
import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/ui/Indicator.dart';
import 'package:flutter_gym_app/ui/pi_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    getOviralWater();
    getLastWight();
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
    wight = days.last.weight ?? 0.0;
  }

  setMapCahrtData() async {
    await context.read<CahrtProvider>().setMapDatatCahrt({
      'last Wight': '$wight',
      'Water': '$water',
      'Burnd Clorise': '$burndCalorise',
      'Food Clorise': '$foodCalorise',
    });
  }

  @override
  void initState() {
    getStatisticExcercise();
    //setMapCahrtData();
  }

  @override
  Widget build(BuildContext context) {
        ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);
    return Scaffold(
       appBar: AppBar(
        title: Text("Overal statistic"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Text(
            //       'Overal statistic',
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text("last Wight :  ",style: CustomTextStyle.getcustomeBouldStyle(),), Text("$wight",style: CustomTextStyle.getcustomeNormalStyle())],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text("Water : ",style: CustomTextStyle.getcustomeBouldStyle()), Text("$water",style: CustomTextStyle.getcustomeNormalStyle())],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text("Burnd Clorise: ",style: CustomTextStyle.getcustomeBouldStyle()), Text("$burndCalorise",style: CustomTextStyle.getcustomeNormalStyle())],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text("Food Clorise : ",style: CustomTextStyle.getcustomeBouldStyle()), Text("$foodCalorise",style: CustomTextStyle.getcustomeNormalStyle())],
            // ),

            Chart([
              ChartItem(title: 'last Wight', value: 100),
              ChartItem(title: 'Water L', value: 200),
              ChartItem(title: 'Burnd Clorise', value: 300),
              ChartItem(title: 'Food Clorise', value: 400)
            ]),
Container(
height: 100.h,
//color: Colors.green,
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  Indicator(color: Colors.blueAccent,size: 10,isSquare: false,text: "last Wight",),
  Indicator(color: Colors.redAccent,size: 10,isSquare: false,text: "Water L",),
  Indicator(color: Colors.deepPurple,size: 10,isSquare: false,text: "Burnd Clorise",),
  Indicator(color: Colors.greenAccent,size: 10,isSquare: false,text: "Food Clorise",),
],),
),


          ],
        ),
      ),
    );
  }
}
