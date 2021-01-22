import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBDayProvider.dart';
import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/services/DBExerciseHelper.dart';
import 'package:flutter_gym_app/ui/trainingTypePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Day> days = [];

  getAllDays() async {
    await context.read<DBDayProvider>().getAllDays();
  }


  @override
  void initState() {
    getAllDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<DBDayProvider>(context, listen: true);
    BuildContext context11= context;
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);
    return days == null
        ? Container()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Days"),
            ),
            body: Consumer<DBDayProvider>(
              builder: (_, value, child) {
                return ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          print(value.dayes[index].weight);
                      //    initExercises(value.dayes[index].id,context11);
                          Get.to(
                              TrainingTypePage(day:value.dayes[index]));
                        },
                        child: CustomeContainer(value.dayes[index])),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: value.dayes.length);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var now = new DateTime.now();
                String dayName = DateFormat('EEEE').format(now);
                String date = DateFormat('d MMM, yyyy').format(now);
                Day day = Day(
                    dayName: dayName,
                    dateOfDate: date,
                    weight: 0,
                    literOfWater: 0.0);

                await context.read<DBDayProvider>().insertIntoDatabase(day);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}

class CustomeContainer extends StatefulWidget {
  Day day;
  CustomeContainer(this.day);
  @override
  _CustomeContainerState createState() => _CustomeContainerState();
}

class _CustomeContainerState extends State<CustomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.date_range_rounded,
            color: Colors.blue,
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            children: [
              Text(
                "${widget.day.dayName}",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text("${widget.day.dateOfDate}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ],
          ),
          Spacer(),
          IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () async {
                await context.read<DBDayProvider>().deleteDay(widget.day);
              }),
        ],
      ),
    );
  }
}
