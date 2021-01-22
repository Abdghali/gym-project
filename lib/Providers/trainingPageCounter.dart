
import 'package:flutter/cupertino.dart';

class TainingPageCounterProvider extends ChangeNotifier{

int weightCounter =0;
int literOfWaterCounter =0;


setwight(int number){
weightCounter=number;
notifyListeners();
}

setWaterCounter(number){
literOfWaterCounter = number;
  notifyListeners();
}
incrementweight(){
weightCounter++;
notifyListeners();
}

decrementweight(){
  if(weightCounter!=0){
 weightCounter--;

  }
notifyListeners();
}


incrementLiterOfWater(){
literOfWaterCounter++;
notifyListeners();
}

decrementLiterOfWater(){
   if(literOfWaterCounter!=0){
literOfWaterCounter--;

  }
notifyListeners();
}

} 