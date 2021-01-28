import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBDayProvider.dart';
import 'package:flutter_gym_app/Providers/DBExerciseProvider.dart';
import 'package:flutter_gym_app/Providers/chartProvider.dart';
import 'package:flutter_gym_app/models/ChartItem.dart';
import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/ui/Indicator.dart';
import 'package:flutter_gym_app/ui/pi_chart.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
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
  double total = 0.0;
  bool isloding = false;

  islodingFalse() {
    setState(() {
      isloding = true;
    });
  }

  calTotal() {
    setState(() {
      total = water + wight + burndCalorise + foodCalorise;
    });
  }

  getStatisticExcercise() async {
    await context.read<DBExerciseProvider>().getAllExercises2();
    getOviralStatisticCaloriseBurnds();
    getOviralStatisticCaloriseFood();
    getOviralWater();
    getLastWight();
    calTotal();
    islodingFalse();
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
    await context.read<CahrtProvider>().setListItemDatatCahrt([
      ChartItem(title: 'last Wight', value: wight+0.0),
      ChartItem(title: 'Liter of Water', value: 200),
      ChartItem(title: 'Burnd Clorise', value: 300),
      ChartItem(title: 'Food Clorise', value: 400)
    ]);
  }
 

  @override
  void initState() {
    getStatisticExcercise();
    setMapCahrtData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(translator.translate("Overal statistic")),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: isloding == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Chart(context.read<CahrtProvider>().mapCahrt),
                  Container(
                    height: 100.h,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Indicator(
                            color: Colors.blueAccent,
                            size: 10,
                            isSquare: false,
                            text: translator.translate("last_Wight")+": $wight",
                          ),
                          Indicator(
                            color: Colors.redAccent,
                            size: 10,
                            isSquare: false,
                            text:translator.translate("Liter_of_water")+ " : $water",
                          ),
                          Indicator(
                            color: Colors.deepPurple,
                            size: 10,
                            isSquare: false,
                            text: translator.translate("Calories_burned")+" : $burndCalorise",
                          ),
                          Indicator(
                            color: Colors.greenAccent,
                            size: 10,
                            isSquare: false,
                            text:translator.translate("Food_Calories")+ " : $foodCalorise",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
