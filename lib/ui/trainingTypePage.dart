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
  TextEditingController textEditingController;
  TextEditingController textEditingController2;
  int numberOfLiterOfWater;
  int dalyWeight;

  @override
  void initState() {
    numberOfLiterOfWater = 0;
    dalyWeight = 0;
    textEditingController =
        TextEditingController(text: '$numberOfLiterOfWater');
    textEditingController2 = TextEditingController(text: '$dalyWeight');
    super.initState();
  }

  increaseNOLOWater() {
    setState(() {
      numberOfLiterOfWater++;
    });
  }

  deccreaseNOLOWater() {
    setState(() {
      numberOfLiterOfWater--;
    });
  }

  increaseDalyWeight() {
    setState(() {
      dalyWeight++;
    });
  }

  decreaseDalyWeight() {
    setState(() {
      dalyWeight--;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);

    return Scaffold(
      appBar: AppBar(title: Text("Exercises"),centerTitle: true,),
      body: SingleChildScrollView(

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              height: 440.h,
             // color: Colors.greenAccent,
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      CustomContainer(exercise: exxersises[index]),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: exxersises.length),
            ),
            SizedBox(
              child: Divider(),
              height: 30.h,
            ),
            Column(
              children: [
                Container(
                    height: 80.h,
                    // color: Colors.lightBlue,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Water Liter"),
                          CustomeContainer3(
                            textEditingController: textEditingController,
                            decrease: deccreaseNOLOWater,
                            increase: increaseNOLOWater,
                          ),
                        ])),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    height: 80.h,
                    //    color: Colors.lime,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("your weight"),
                        CustomeContainer3(
                          textEditingController: textEditingController2,
                          decrease: decreaseDalyWeight,
                          increase: increaseDalyWeight,
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            RaisedButton(onPressed: () {
              print(textEditingController.text);
              print(textEditingController2.text);
            }),
          ],
        ),
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
