import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CartPageController extends ChangeNotifier {
  List<dynamic> data = [
    {"Title": "Egg", "description": "Hen's asset", "qty": 0},
    {"Title": "Chicken", "description": "Hen's body", "qty": 0},
    {"Title": "Chicken Gravy", "description": " with Hen", "qty": 0},
  ];
  List<dynamic> list = [];
  bool viewCart = false;
  int totalcount = 0;

  void addQuantity(int index) {
    data[index]["qty"]++;
    data = data;
    notifyListeners();
  }

  void minusQuantity(int index) {
    data[index]["qty"]--;
    data = data;
    notifyListeners();
  }

  void isViewSelected(bool a) {
    viewCart = a;
    notifyListeners();
  }

  void countItems(index) {
    list.add(data[index]);
    notifyListeners();
  }
}
