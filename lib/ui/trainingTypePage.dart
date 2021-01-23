import 'package:flutter/material.dart';
import 'package:flutter_gym_app/Providers/DBDayProvider.dart';
import 'package:flutter_gym_app/Providers/DBExerciseProvider.dart';
import 'package:flutter_gym_app/Providers/trainingPageCounter.dart';
import 'package:flutter_gym_app/models/day.dart';
import 'package:flutter_gym_app/models/exercise.dart';
import 'package:flutter_gym_app/services/DBExerciseHelper.dart';
import 'package:flutter_gym_app/ui/exercisesDetailsPage.dart';
import 'package:flutter_gym_app/ui/indecator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class TrainingTypePage extends StatefulWidget {
  Day day;
  TrainingTypePage({this.day});

  @override
  _TrainingTypePageState createState() => _TrainingTypePageState();
}

class _TrainingTypePageState extends State<TrainingTypePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 360.0, height: 640.0, allowFontScaling: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          CustomeContainer1(widget.day.id),
          CustomContainer4(
            day: widget.day,
          ),
        ],
      ),
    );
  }
}

/// custome container for multy item (as list )
class CustomeContainer1 extends StatefulWidget {
  int day_id;
  CustomeContainer1(this.day_id);
  @override
  _CustomeContainer1State createState() => _CustomeContainer1State();
}

class _CustomeContainer1State extends State<CustomeContainer1> {
  getAlllWxcersise() async {
    await context.read<DBExerciseProvider>().getAllExercises(widget.day_id);
  }

  @override
  void setState(fn) {
    getAlllWxcersise();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<DBExerciseProvider>(builder: (_, value, child) {
        return SingleChildScrollView(
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
                        InkWell(
                          onTap: (){
                            Get.to(ExercisesDetailsPage(widget.day_id,value.exercises[index].id));
                          },
                          
                          child: CustomContainer(exercise: value.exercises[index])),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: value.exercises.length),
              ),
            ],
          ),
        );
      }),
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
                  Text("Tareget : ${exercise.targetNumber}    ",
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
                beginvalue: exercise.targetNumber * 0.01,
                endValue: exercise.reachedNumber * 0.01,
              )),

          Container(
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(
              color: exercise.done != 1 ? Colors.red : Colors.green,
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
  int type;
  Day day;
  String textValue;
  cutomeContainer2({this.textValue, this.day, this.type});
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 50,
      child: TextField(
        textAlign: TextAlign.center,
        controller: textEditingController,
        keyboardType: TextInputType.number,
        onChanged: (value) async {
          double counter = double.parse(value);
          if (type == 1) {
            await context
                .read<TainingPageCounterProvider>()
                .setWaterCounter(counter);
          } else if (type == 2) {
            await context.read<TainingPageCounterProvider>().setwight(counter);
          }
        },
        decoration: InputDecoration(
          hintText: '${textValue}',
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
  int type;
  Day day;

  CustomeContainer3({this.type, this.day});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: Row(
        children: [
          Consumer<TainingPageCounterProvider>(builder: (_, value, child) {
            return IconButton(
                icon: Icon(Icons.add),
                onPressed: () => type != 2
                    ? value.incrementLiterOfWater()
                    : value.incrementweight());
          }),
          SizedBox(
            width: 5.w,
          ),
          Consumer<TainingPageCounterProvider>(builder: (_, value, child) {
            return cutomeContainer2(
              textValue: type != 2
                  ? '${value.literOfWaterCounter}'
                  : '${value.weightCounter}',
              type: type,
              day: day,
            );
          }),
          SizedBox(
            width: 5.w,
          ),
          Consumer<TainingPageCounterProvider>(builder: (_, value, child) {
            return IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => type != 2
                    ? value.decrementLiterOfWater()
                    : value.decrementweight());
          }),
        ],
      ),
    );
  }
}

/// DraggableScreollableSheet  for more information about weight and Liter of water
class CustomContainer4 extends StatelessWidget {
  Day day;
  CustomContainer4({this.day});
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
                          Text("Liter of water"),
                          CustomeContainer3(
                            day: day,
                            type: 1,
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
                          day: day,
                          type: 2,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 40.h,
                ),
                CustomeButton(
                  day: day,
                ),
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
  Day day;
  CustomeButton({this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 35.h,
      child: RaisedButton(
        color: Colors.white,
        child: Text("Submit"),
        onPressed: () async {
          double literOfWater = await context
              .read<TainingPageCounterProvider>()
              .literOfWaterCounter;
          double wight =
              await context.read<TainingPageCounterProvider>().weightCounter;
          await context.read<DBDayProvider>().updateDay(Day(
                id: day.id,
                dayName: day.dayName,
                dateOfDate: day.dateOfDate,
                literOfWater: literOfWater,
                weight: wight,
              ));

          print(
              'liter of water ${await context.read<TainingPageCounterProvider>().literOfWaterCounter}');
          print(
              ' wight = ${await context.read<TainingPageCounterProvider>().weightCounter}');

//customeAlertDialoge();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green)),
      ),
    );
  }
}

customeAlertDialoge() {
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("cancl"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("successfully"),
      content: Text("Submitted successfully"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
