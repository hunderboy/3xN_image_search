import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api/custom_log_interceptor.dart';
import '../api/kakao_data.dart';
import '../api/kakao_rest_client.dart';
import '../model/Post.dart';
import '../search_bar/flappy_search_bar_ns.dart';
import '../singleton.dart';

class LobbyController extends GetxController {

  // final SearchBarController<Post> searchBarController = SearchBarController();
  bool isReplay = false;

  // 외부로 부터 데이터 가져오는 Future
  Future<List<Post>> getALlPosts(String? text) async {
    await Future.delayed(Duration(seconds: text?.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text?.length == 5) throw Error(); // 에러 발생 Test
    if (text?.length == 6) return [];     // 검색 결과 없음 Test

    List<Post> posts = [];
    var random = Random();
    for (int i = 0; i < 4; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }


/// ---------------------------------------------------------------------------------

  final SearchBarController<KImage> searchBarController = SearchBarController();

  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  Future<List<KImage>> getSearchedImages(String? searchingText) async {
    dio.options.headers["Authorization"] = Singleton().KAKAO_API_KEY;
    final client = RestClient(dio);

    try {
      KakaoData valueFuture = await client.getImageDatas("손흥민", 30, 1);
      print('검색중......');
      // print("total_count : ${valueFuture.meta.total_count}");
      // print("pageable_count : ${valueFuture.meta.pageable_count}");
      print("is_end : ${valueFuture.meta.is_end}");
      // print("KakaoData.meta.is_end : ${valueFuture.meta.is_end}");
      // print("KakaoData.documents.length : ${valueFuture.documents.length}");
      print("KakaoData.documents.image_url : ${valueFuture.documents[0].image_url}");

      List<KImage> images = valueFuture.documents;
      return images;
    }catch (err) {
      print('Caught error:$err');
      throw Error(); // 에러 처리
    }
  }




}