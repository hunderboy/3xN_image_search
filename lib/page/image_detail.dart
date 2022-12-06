import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controller/image_detail_controller.dart';

class ImageDetail extends GetView<ImageDetailController>  {

  @override
  Widget build(BuildContext context) {
    Get.put(ImageDetailController());


    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 이미지'),
      ),
      body: SafeArea(
        child:
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.image_url,
                    /// 긴 이미지 테스트
                    // imageUrl: "https://cdn.newspenguin.com/news/photo/201908/676_1083_1418.jpg",
                    fit: BoxFit.cover,
                  ),
                  Column(
                      children: [
                        Text("display_sitename : ${controller.display_sitename}"),
                        Text("datetime : ${controller.datetime}"),
                      ]
                  )
                ]
              )
            )

          )
      )
    );
  }
}