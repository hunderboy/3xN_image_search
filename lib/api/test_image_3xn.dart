import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

    dio.options.headers["Authorization"] = "KakaoAK 53a7d75ab73902f2362333caed881270"; // config your dio headers globally
    final _client = RestClient(dio);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TestImage3xN'),
      ),
      body: Center(
        // child: Text('Dio'),

        child:
        FutureBuilder<KakaoData?>(
          future: _client.getImageDatas(
              "안녕",/// 검색어
              30,   /// 1 페이지 표시할 이미지 개수
              1     /// page 번호
          ), // 데이터 요청
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              KakaoData? kakaoDataInfo = snapshot.data;

              if (kakaoDataInfo != null) {
                // print("total_count : "+kakaoDataInfo.meta.total_count.toString());
                // print("pageable_count : "+kakaoDataInfo.meta.pageable_count.toString());
                // print("is_end : "+kakaoDataInfo.meta.is_end.toString());

                print("KakaoData.meta.is_end : "+kakaoDataInfo.meta.is_end.toString());
                print("KakaoData.documents.length : "+kakaoDataInfo.documents.length.toString());
                print("KakaoData.documents.image_url : "+kakaoDataInfo.documents[0].image_url.toString());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('KakaoData.meta.is_end : ${kakaoDataInfo.meta.is_end.toString()}'),
                    Text('KakaoData.documents.length : ${kakaoDataInfo.documents.length.toString()}'),
                    Text('KakaoData.documents.image_url : ${kakaoDataInfo.documents[0].image_url.toString()}'),
                  ],
                );
                return const Text('is here');
              }

              return const Text('검색된 데이터 없음');
            }
            return const CircularProgressIndicator();
          }
        )
      )
    );
  }
}