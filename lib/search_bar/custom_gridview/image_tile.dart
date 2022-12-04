import 'package:flutter/material.dart';



class ImageTile extends StatelessWidget {
  ImageTile({Key? key,
    required this.title,
  }) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {

    return
      GestureDetector(
        onTap: () {
          /// 가이드 상세 보기 화면으로 이동
          // Get.toNamed("/GuideDetailPage?viewIndex=$viewIndex&guideUrl=$guideUrl");
          // Get.toNamed("/GuideDetailPage", arguments: exerciseObject);
        },
        child: Container(
          width: double.infinity,
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: Colors.redAccent,
              width: double.infinity,
              // CachedNetworkImage(
              //   imageUrl: imageThumbnailUrl,
              //   fit: BoxFit.cover,
              // ),
            )
          )
        )
      );
  }

}