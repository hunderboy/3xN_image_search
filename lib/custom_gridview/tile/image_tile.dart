import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 기존의 staggered_grid_view 에서
///
class ImageTile extends StatelessWidget {
  ImageTile({Key? key,
    required this.collection,
    required this.thumbnail_url,
    required this.image_url,
    required this.display_sitename,
    required this.doc_url,
    required this.datetime,
    required this.width,
    required this.height,
  }) : super(key: key);

  String collection;
  String thumbnail_url;
  String image_url;
  String display_sitename;
  String doc_url;
  String datetime;
  int width;
  int height;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        /// 이미지 상세 보기 화면으로 이동
        // Get.toNamed("/GuideDetailPage",
        //   arguments: image_url,
        //   arguments: display_sitename,
        //   arguments: datetime,
        // );
        Get.toNamed('/ImageDetail/value?'
            'image_url=$image_url&'
            'display_sitename=$display_sitename&'
            'datetime=$datetime'
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: CachedNetworkImage(
          imageUrl: thumbnail_url,
          fit: BoxFit.cover,
        )
      )
    );
  }

}