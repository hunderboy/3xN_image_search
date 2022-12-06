import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/kakao_data.dart';
import '../custom_gridview/tile/image_tile.dart';
import '../getx_controller/lobby_controller.dart';
import '../search_bar/flappy_search_bar_ns.dart';
import '../singleton.dart';


class Lobby extends GetView<LobbyController> {
  const Lobby({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put(LobbyController());

    return Scaffold(
      appBar: AppBar(
        title:
        // const Text('이미지 검색'),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightGreen, // foreground
            ),
            onPressed: () {
              Get.toNamed("/TestImage3xN");
            },
            child: const Text("API 통신 테스트"),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child:
        SearchBar<KImage>(
            onSearch: controller.getSearchedImages, /// 검색 함수 설정
            searchBarController: controller.searchBarController,
            debounceDuration: const Duration(milliseconds: 1000), /// 1초후 검색이 실행

            /// Padding 설정
            searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
            headerPadding: const EdgeInsets.symmetric(horizontal: 10),
            listPadding: const EdgeInsets.symmetric(horizontal: 10),

            /// 예외상황 UI 설정
            cancellationWidget: const Text("취소"),
            onCancelled: () {Singleton().showToast("검색이 취소되었습니다.");},
            placeHolder: const Center(child: Text("이미지를 검색하여 주세요")),
            emptyWidget: const Center(child: Text("검색 결과가 없습니다.")),

            onItemFound: (KImage? k_Image, int index) {

              if (k_Image != null) {
                return  ImageTile(
                  collection : k_Image.collection,
                  thumbnail_url : k_Image.thumbnail_url,
                  image_url : k_Image.image_url,
                  display_sitename : k_Image.display_sitename,
                  doc_url : k_Image.doc_url,
                  datetime : k_Image.datetime,
                  width : k_Image.width,
                  height : k_Image.height,
                );
              }else{
                return ImageTile(
                  collection : "result_empty",
                  thumbnail_url : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE1BFq0h-RvrEBWCMPudD2QMYcG2BDJVDYNw&usqp=CAU",
                  image_url : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE1BFq0h-RvrEBWCMPudD2QMYcG2BDJVDYNw&usqp=CAU",
                  display_sitename : "result_empty",
                  doc_url : "result_empty",
                  datetime : "result_empty",
                  width : 0,
                  height : 0,
                );
              }

            }
        )

      )
    );

  }
}