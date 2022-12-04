import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'lobby.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // 화면이 시작되고 몇초간의 딜레이 후, 다음 화면으로 넘어가는 부분
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Lobby()),
      (route) => false)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: 300,
              // width: 300,
              child:
              Lottie.asset(
                  // "assets/lottie/text-animation.json",
                  "assets/lottie/8546-aperture-logo-loading.json",
                  controller: _controller, onLoaded: (composition) {
                    _controller.addStatusListener((status) {

                      // 애니메이션이 사라지면 다시 생성
                      if (status == AnimationStatus.dismissed)
                        _controller.forward();
                      // 애니메이션이 끝나면 반대로 재생
                      else if (status == AnimationStatus.completed)
                        _controller.reverse();
                    });

                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  }
              )
            )
          ],
        ),

      )
    );

  }
}