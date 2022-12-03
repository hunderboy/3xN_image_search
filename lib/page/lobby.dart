import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Lobby extends StatelessWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module'),
      ),
      body: SafeArea(
        child: Center(
          child: 
          Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView(
                  primary: true, // 리스트 스크롤 허용
                  shrinkWrap: true, // 아이템 수만큼 높이 설정
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/Retrofit_Dio_Json");
                      },
                      child: const Text("Retrofit+Dio+Json"),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/Retrofit_Dio_Json");
                      },
                      child: const Text("button2"),
                    ),

                  ],
                ),
              ],
            ),
          )
        )
      ),
    );

  }
}