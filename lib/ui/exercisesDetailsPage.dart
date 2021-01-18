import 'package:flutter/material.dart';
import 'package:flutter_gym_app/utilities/customTextStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExercisesDetailsPage extends StatefulWidget {
  @override
  _ExercisesDetailsPageState createState() => _ExercisesDetailsPageState();
}

class _ExercisesDetailsPageState extends State<ExercisesDetailsPage> {
  TextEditingController textEditingController1;
  TextEditingController textEditingController2;
  TextEditingController textEditingController3;
  TextEditingController textEditingController4;
  int number=0;
  double   weight=0;
  double caloriesBurned=0;
  double caloriesFood=0;

  numberIncrease() {number++;}
  numberDecrease() {number--;}
  weightIncrease() {weight++;}
  weightDecrease() {weight--;}
  caloriesBurnedIncrease() {caloriesBurned++;}
  caloriesBurnedDecrease() {caloriesBurned--;}
  caloriesFoodBIncrease() {caloriesFood++;}
  caloriesFoodDecrease() {caloriesFood--;}

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Exercise Details Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            CustomeContainer1(
              textEditingController: textEditingController1,
              title: 'Number :',
              increase: numberIncrease,
              decrease: numberDecrease,
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomeContainer1(
                textEditingController: textEditingController2,
                title: "Thee weight :",
                increase: numberIncrease,
                decrease: weightDecrease,
                ),
            SizedBox(
              height: 40.h,
            ),
            CustomeContainer1(
              textEditingController: textEditingController3,
              title: "Calories burned :",
              increase: caloriesBurnedIncrease,
              decrease: caloriesBurnedDecrease,
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomeContainer1(
              textEditingController: textEditingController4,
              title: "Food Calories :",
              increase: caloriesFoodBIncrease,
              decrease: caloriesFoodDecrease,
            ),
            SizedBox(
              height: 60.h,
            ),
            CustomeButton(
              title: 'Submit',
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeButton extends StatelessWidget {
  String title;
  CustomeButton({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text('$title'),
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue)),
          onPressed: () {}),
    );
  }
}

class CustomeContainer1 extends StatelessWidget {
  String title;
  TextEditingController textEditingController;
  Function increase;
  Function decrease;
  CustomeContainer1(
      {this.title, this.textEditingController, this.increase, this.decrease});
  @override
  Widget build(BuildContext context) {
    return Container(
    //  color: Colors.yellow,
      height: 80.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 80.h,
            width: 150.w,
         //   color: Colors.red[200],
            child: Center(child: Text('$title',style: CustomTextStyle.getcustomeBouldStyle(),)),
          ),
          CustomeContainer3(
            textEditingController: textEditingController,
            increase: increase,
            decrease: decrease,
          ),
        ],
      ),
    );
  }
}

class cutomeContainer2 extends StatelessWidget {
  TextEditingController textEditingController;
  cutomeContainer2({this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 50,
      child: TextField(
        textAlign: TextAlign.center,
        controller: textEditingController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '5',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}

class CustomeContainer3 extends StatelessWidget {
  TextEditingController textEditingController;
  Function increase;
  Function decrease;

  CustomeContainer3({this.textEditingController, this.increase, this.decrease});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.add), onPressed: () => increase),
          SizedBox(
            width: 5.w,
          ),
          cutomeContainer2(textEditingController: textEditingController),
          SizedBox(
            width: 5.w,
          ),
          IconButton(icon: Icon(Icons.remove), onPressed: () {}),
        ],
      ),
    );
  }
}
