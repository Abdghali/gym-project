import 'package:flutter/material.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainingTypePage extends StatefulWidget {
  @override
  _TrainingTypePageState createState() => _TrainingTypePageState();
}

class _TrainingTypePageState extends State<TrainingTypePage> {
  List<Exercise> exxersises = [
    Exercise(trainingName: "bacboon", time: 10, done: false),
    Exercise(trainingName: "bacboon", time: 10, done: true),
    Exercise(trainingName: "bacboon", time: 10, done: false),
    Exercise(trainingName: "bacboon", time: 10, done: true),
    Exercise(trainingName: "bacboon", time: 10, done: false),
    Exercise(trainingName: "bacboon", time: 10, done: true),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            height: 440.h,
            color: Colors.greenAccent,
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    CustomContainer(exercise: exxersises[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount: exxersises.length),
          ),
          Column(
            children: [
              Container(
                  height: 60.h,
                  color: Colors.lightBlue,
                  child: Row(children: [Text("Your waight 100")])),
              Container(
                  height: 60.h,
                  color: Colors.lime,
                  child: Row(
                    children: [Text("Water ammount 10 l")],
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  Exercise exercise;
  CustomContainer({this.exercise});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo2.png'))),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            children: [
              Text(
                "${exercise.trainingName}",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text("Time : ${exercise.time}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ],
          ),
          Spacer(),
          Container(
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(
              color: exercise.done == true ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
