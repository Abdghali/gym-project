import 'package:flutter/cupertino.dart';

class CahrtProvider extends ChangeNotifier {
  Map<String, dynamic> mapCahrt;

  setMapDatatCahrt(Map<String, dynamic> newMapCahrt) {
    this.mapCahrt = newMapCahrt??[];
    notifyListeners();
  }
}
