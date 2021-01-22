import 'package:flutter/material.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/ui/indecator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportPage extends StatefulWidget {

  @override
  _ReportPageState createState() => _ReportPageState();
}
 List<Exercise> exxersises = [
    // Exercise(trainingName: "bacboon", time: 10, done: false),
    // Exercise(trainingName: "bacboon", time: 10, done: true),
    // Exercise(trainingName: "bacboon", time: 10, done: false),
    // Exercise(trainingName: "bacboon", time: 10, done: true),
    // Exercise(trainingName: "bacboon", time: 10, done: false),
    // Exercise(trainingName: "bacboon", time: 10, done: true),
  ];
class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
     ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises Statistec"),
        centerTitle: true,
      ),
      body:CustomeContainer1(exxersises),
       
       
    );
  }
}

/// custome container for multy item (as list )
class CustomeContainer1 extends StatefulWidget {
    List exxersises;

CustomeContainer1(this.exxersises);
  @override
  _CustomeContainer1State createState() => _CustomeContainer1State();
}

class _CustomeContainer1State extends State<CustomeContainer1> {

  @override
  Widget build(BuildContext context) {
    return Container(
       child:SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                  ),
                  height: 515.h,
                  // color: Colors.greenAccent,
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          CustomContainer(exercise: widget.exxersises[index]),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: widget.exxersises.length),
                ),
              
              ],
            ),
          ),
    );
  }
}
 //custome container for Item of Excersises
class CustomContainer extends StatelessWidget {
  Exercise exercise;
  CustomContainer({this.exercise});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
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
                  Text("Time : ${exercise.trainingName}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      )),
                ],
              ),
            ],
          ),
          //  Spacer(),
          Container(
              height: 40,
              width: 40,
              child: Indecator(
                size: 40.0,
                beginvalue: 0.2,
                endValue: 0.9,
              )),
        ],
      ),
    );
  }
}