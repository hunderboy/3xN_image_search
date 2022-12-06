import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/custom_log_interceptor.dart';
import '../api/kakao_data.dart';
import '../api/kakao_rest_client.dart';
import '../getx_controller/lobby_controller.dart';
import '../model/Post.dart';
import '../search_bar/flappy_search_bar_ns.dart';
import '../singleton.dart';


class Lobby extends GetView<LobbyController> {
  Lobby({Key? key}) : super(key: key);

  // final dio = Dio()
  //   ..interceptors.add(
  //     CustomLogInterceptor(),
  //   );


  @override
  Widget build(BuildContext context) {
    Get.put(LobbyController());

    // dio.options.headers["Authorization"] = Singleton().KAKAO_API_KEY;
    // final client = RestClient(dio);

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
            onSearch: controller.getSearchedImages, /// 검색 함수 Future
            searchBarController: controller.searchBarController,
            debounceDuration: const Duration(milliseconds: 1000), /// 1초후 검색이 실행되게 함

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
              return Container(
                  child:
                  Container(
                      width: double.infinity,
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            color: Colors.redAccent,
                            width: double.infinity,
                            child:
                            CachedNetworkImage(
                              imageUrl: k_Image!.thumbnail_url,
                              fit: BoxFit.cover,
                            ),
                          )
                      )
                  )

              );
            }
        )


        // SearchBar<Post>(
        //   onSearch: controller.getALlPosts, /// 검색 함수 Future
        //   // onSearch:  client.getImageDatas("손흥민", 30, 1),
        //   searchBarController: controller.searchBarController,
        //   debounceDuration: const Duration(milliseconds: 1000), /// 1초후 검색이 실행되게 함
        //
        //   /// Padding 설정
        //   searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
        //   headerPadding: const EdgeInsets.symmetric(horizontal: 10),
        //   listPadding: const EdgeInsets.symmetric(horizontal: 10),
        //
        //   /// 예외상황 UI 설정
        //   cancellationWidget: const Text("취소"),
        //   onCancelled: () {Singleton().showToast("검색이 취소되었습니다.");},
        //   placeHolder: const Center(child: Text("이미지를 검색하여 주세요")),
        //   emptyWidget: const Center(child: Text("검색 결과가 없습니다.")),
        //
        //   // indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1), // 타일 비율 설정
        //
        //   // mainAxisSpacing: 10,
        //   // crossAxisSpacing: 10,
        //   // crossAxisCount: 2,
        //
        //   onItemFound: (Post? post, int index) {
        //     return Container(
        //       child:
        //       Container(
        //           width: double.infinity,
        //           child:
        //           ClipRRect(
        //               borderRadius: BorderRadius.circular(14),
        //               child: Container(
        //                 color: Colors.redAccent,
        //                 width: double.infinity,
        //                 // CachedNetworkImage(
        //                 //   imageUrl: imageThumbnailUrl,
        //                 //   fit: BoxFit.cover,
        //                 // ),
        //               )
        //           )
        //       )
        //
        //       // ImageTile(
        //       //   // title: deduplicatedList[index].name,
        //       //   title : "텍스트"
        //       // )
        //
        //       // ListTile(
        //       //   title: Text(post?.title ?? 'fail' ),
        //       //   isThreeLine: true,
        //       //   subtitle: Text(post?.body ?? 'fail'),
        //       //   onTap: () {
        //       //     // 페이지 이동
        //       //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
        //       //   }
        //       // )
        //     );
        //   }
        // )

      )
    );

  }
}