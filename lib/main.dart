import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/lobby.dart';
import 'page/splash/splash.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // /// 상태파 컬러 앱 전체 적용
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(
    //       /// ios
    //       statusBarBrightness: Brightness.dark, // ios 상태바 텍스트 컬러 = white
    //     )
    // );

    return GetMaterialApp(
        title: 'FunctionModule',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily: 'Pretendard',   /// 전체 Text 폰트 적용
        ),
        initialRoute: "/SplashLottie",

        getPages: [

          /// 앱 첫 시작 로딩페이지
          GetPage(
              name: "/SplashLottie",
              page: () => Splash(),
              curve: const Cubic(0.4, 0.0, 0.4, 0.0),
              transition: Transition.rightToLeft),

          GetPage(
              name: "/",
              page: () => const Lobby(),
              transition: Transition.rightToLeft),
          // GetPage(
          //     name: "/ShowPicture",
          //     page: () => ShowPicture(),
          //     transition: Transition.rightToLeft),

        ]
    );

  }
}
