import 'package:assignment_brandi/singleton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../custom_gridview/tile/image_tile.dart';
import 'custom_log_interceptor.dart';
import 'kakao_data.dart';
import 'kakao_rest_client.dart';

class TestImage3xN extends StatelessWidget {
  TestImage3xN({Key? key}) : super(key: key);

  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  @override
  Widget build(BuildContext context) {

    dio.options.headers["Authorization"] = Singleton().KAKAO_API_KEY;
    final client = RestClient(dio);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TestImage3xN'),
      ),
      body: FutureBuilder<KakaoData?>(
        future: client.getImageDatas(
            "손흥민",   /// 검색어
            30,       /// 1 페이지 표시할 이미지 개수
            1         /// page 번호
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            KakaoData? kakaoDataInfo = snapshot.data;

            if (kakaoDataInfo != null) {
              /// 데이터 확인
              // print("total_count : "+kakaoDataInfo.meta.total_count.toString());
              // print("pageable_count : "+kakaoDataInfo.meta.pageable_count.toString());
              // print("is_end : "+kakaoDataInfo.meta.is_end.toString());
              // print("KakaoData.meta.is_end : "+kakaoDataInfo.meta.is_end.toString());
              // print("KakaoData.documents.length : "+kakaoDataInfo.documents.length.toString());
              // print("KakaoData.documents.image_url : "+kakaoDataInfo.documents[0].image_url.toString());
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child:
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,        // 1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1/1,    // item 의 가로 1, 세로 2 의 비율 (기본은 1대1 비뮬)
                      mainAxisSpacing: 10,      // item 간의 수직 Padding
                      crossAxisSpacing: 14,     // item 간의 수평 Padding
                    ),
                    itemCount: kakaoDataInfo.documents.length,
                    itemBuilder: (context, index) {
                      /// 이미지 url 확인
                      // print("KakaoData.documents.image_url : "+kakaoDataInfo.documents[index].image_url.toString());
                      return  ImageTile(
                        collection : kakaoDataInfo.documents[index].collection,
                        thumbnail_url : kakaoDataInfo.documents[index].thumbnail_url,
                        image_url : kakaoDataInfo.documents[index].image_url,
                        display_sitename : kakaoDataInfo.documents[index].display_sitename,
                        doc_url : kakaoDataInfo.documents[index].doc_url,
                        datetime : kakaoDataInfo.documents[index].datetime,
                        width : kakaoDataInfo.documents[index].width,
                        height : kakaoDataInfo.documents[index].height,
                      );
                    }
                )
              );
            }
            return const Text('검색된 데이터 없음');
          }
          return const CircularProgressIndicator(); // 로딩중
        }
      )
    );
  }
}