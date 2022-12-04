import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Singleton {
  static final Singleton _instance = Singleton._internal();
  factory Singleton() {
    return _instance;
  }
  // 싱글톤 초기화 코드 = 싱글톤 클래스가 최초 생성될때만 1회 발생
  Singleton._internal() {
    // do nothing
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.redAccent,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

}