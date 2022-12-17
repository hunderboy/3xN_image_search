

import 'package:assignment_brandi/page/method_getx.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
            title: const Text("이미지 검색")
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ElevatedButton(
                child: const Text("Getx 방식"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const MethodGetx();
                  }));
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text("BloC 방식"),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //   return BlocDisplayWidget();
                  // }));
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text("Provider 방식"),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //   return PlusStatefulDisplayWidget();
                  // }));
                },
              ),
            ),
          ],
        ),
      );
  }
}