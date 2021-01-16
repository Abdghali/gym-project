import 'package:flutter/material.dart';
import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Day> days = [
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
    Day(dateOfDate: "20/20/2021", dayName: "Satarday"),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) => CustomeContainer(),
          separatorBuilder: (context, index) => Divider(),
          itemCount: days.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CustomeContainer extends StatefulWidget {
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
                "Staterday",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text("20/20/2021",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ],
          ),
          Spacer(),
          Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
