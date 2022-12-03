import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    /// 상태파 컬러 앱 전체 적용
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          /// ios
          statusBarBrightness: Brightness.dark, // ios 상태바 텍스트 컬러 = white
        )
    );

    return GetMaterialApp(
        title: 'FunctionModule',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily: 'Pretendard',   /// 전체 Text 폰트 적용
        ),
        // initialRoute: "/",

        getPages: [

          GetPage(
              name: "/",
              page: () => const Lobby(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/Retrofit_Dio_Json",
              page: () => RetrofitDioJson(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/CustomCircleDialIndicator",
              page: () => const CustomCircleDialIndicator(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/PermissionHandler",
              page: () => const PermissionHandlerPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/Ready",
              page: () => const Ready(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/ChangeStatusBar",
              page: () => const ChangeStatusBar(),
              transition: Transition.rightToLeft),

        ]
    );

  }
}
