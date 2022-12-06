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
              child: CachedNetworkImage(
                imageUrl: controller.image_url,
                fit: BoxFit.cover,
              )
            )


        // Column(
        //   children: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () => Navigator.of(context).pop(),
        //     ),
        //     Text("Detail"),
        //   ]
        // )

      )
    );
  }
}