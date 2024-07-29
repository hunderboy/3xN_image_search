import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AttendeeItem extends StatelessWidget{
  AttendeeItem({Key? key,
    required this.profileIMG,
    required this.nickName
  }) : super(key: key);

  late String profileIMG = "assets/image/test_img/lesson_summury_img.jpg";
  late String nickName = "default_user";

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
        maxHeight: 90,
        child: Container(
            margin: const EdgeInsets.only(top: 5,bottom: 5),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
                children: [
                  /// 프로필 이미지
                  AspectRatio(
                      aspectRatio: 1 / 1, // 정사각형 비율 유지
                      child: ClipOval(
                        child: CachedNetworkImage(
                          // placeholder: ,
                          imageUrl: profileIMG,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                  const SizedBox(width: 14), // 이미지와 텍스트 간의 간격 설정
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: nickName,
                                      style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500,))
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: const Icon(Icons.chevron_right, size: 20, color: Color(0xffC7C7C7)),
                                  onPressed: () {}
                              ),
                            ),
                          ]
                      )
                  ),
                ]
            )
        )
    );
  }
}
