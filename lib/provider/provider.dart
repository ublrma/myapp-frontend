import 'package:flutter/material.dart';
import 'package:my_app/Model/User.dart';
import 'package:my_app/Model/index.dart';

class CommonProvider extends ChangeNotifier {
  List<ConvertedFile> zaruud = [];
  List<int> wishListIds = [];
  int currentIdx = 0;
  bool isLoggedIn = false;
  String currentUsrId = "";
  User? usr;
  

  void updateUser(User userData) {
    usr = userData;
    notifyListeners();
  }

  void setzaruud(List<ConvertedFile> data) {
    zaruud = data;
    notifyListeners();
  }



  void onLogin() {
    isLoggedIn = true;
    notifyListeners();
  }

  void onLogout() {
    isLoggedIn = false;
    notifyListeners();
  }
}
