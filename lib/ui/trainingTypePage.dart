import 'package:flutter/material.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/ui/indecator.dart';
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
      appBar: AppBar(
        title: Text("Exercises"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CustomeContainer1(exxersises),
          CustomContainer4(
              textEditingController1: textEditingController,
              textEditingController2: textEditingController2,
              increaseDalyWeight: increaseDalyWeight,
              decreaseDalyWeight: decreaseDalyWeight,
              increaseNOLOWater: increaseNOLOWater,
              deccreaseNOLOWater: deccreaseNOLOWater),
        ],
      ),
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


/// custome container for Item of Excersises
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
                  Text("Time : ${exercise.time}",
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

/// custome Container for  textfeaild (cercly circular)
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

// cutome container for counter 
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

/// DraggableScreollableSheet  for more information about weight and Liter of water
class CustomContainer4 extends StatelessWidget {
  TextEditingController textEditingController1;
  TextEditingController textEditingController2;
  Function deccreaseNOLOWater;
  Function increaseNOLOWater;
  Function decreaseDalyWeight;
  Function increaseDalyWeight;

  CustomContainer4(
      {this.textEditingController1,
      this.textEditingController2,
      this.increaseDalyWeight,
      this.decreaseDalyWeight,
      this.increaseNOLOWater,
      this.deccreaseNOLOWater});
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1.h,
      maxChildSize: 0.6.h,
      minChildSize: 0.1.h,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  height: 8.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                    height: 80.h,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Water Liter"),
                          CustomeContainer3(
                            textEditingController: textEditingController1,
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
                     SizedBox(
                  height: 40.h,
                ),
                CustomeButton(),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        );
      },
    );
  }
}


/// custome button for submit the weight and Liter of water
class CustomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height:35.h,
      child: RaisedButton(
        color: Colors.white,
        child: Text("Submit"),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.green)),
            ),
    );
  }
}
