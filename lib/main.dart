import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'api/test_image_3xn.dart';
import 'page/home.dart';
import 'page/image_detail.dart';
import 'page/method_getx.dart';
import 'page/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
          // statusBarBrightness: Brightness.light,
        )
    );

    return GetMaterialApp(
        title: 'FunctionModule',
        theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: const ColorScheme.light(surface: Colors.white),
          // fontFamily: 'Pretendard',   /// 전체 Text 폰트 적용
        ),
        // initialRoute: "/SplashLottie",
        initialRoute: "/Home",

        getPages: [

          /// 앱 첫 시작 로딩페이지
          GetPage(
              name: "/SplashLottie",
              page: () => Splash(),
              curve: const Cubic(0.4, 0.0, 0.4, 0.0),
              transition: Transition.rightToLeft),

          GetPage(
              name: "/Home",
              page: () => const Home(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/",
              page: () => const MethodGetx(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/ImageDetail",
              page: () => ImageDetail(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/TestImage3xN", // 이미지 테스트 화면
              page: () => TestImage3xN(),
              transition: Transition.rightToLeft),
        ]
    );

  } // test
}
