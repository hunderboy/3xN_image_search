import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api/custom_log_interceptor.dart';
import '../api/kakao_data.dart';
import '../api/kakao_rest_client.dart';
import '../search_bar/flappy_search_bar_ns.dart';
import '../singleton.dart';


class MethodGetxController extends GetxController {

  /// 검색창 컨트롤러 설정
  final SearchBarController<KImage> searchBarController = SearchBarController();

  /// dio 선언
  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  /// Future : 이미지 검색
  Future<List<KImage>> getSearchedImages(String? searchingText) async {

    if(searchingText != null){
      dio.options.headers["Authorization"] = Singleton().KAKAO_API_KEY;
      final client = RestClient(dio);

      try {
        KakaoData valueFuture = await client.getImageDatas(searchingText, 30, 1);
        List<KImage> images = valueFuture.documents;
        return images;
      }catch (err) {
        print('Caught error:$err');
        throw Error(); // 에러 처리
      }
    }else{
      List<KImage> images = [];
      return images;
    }

  }


/// 테스트 코드 ---------------------------------------------------------------------------------

  // final SearchBarController<Post> searchBarController = SearchBarController();
  // bool isReplay = false;
  // /// Post : Future
  // Future<List<Post>> getALlPosts(String? text) async {
  //   await Future.delayed(Duration(seconds: text?.length == 4 ? 10 : 1));
  //   if (isReplay) return [Post("Replaying !", "Replaying body")];
  //   if (text?.length == 5) throw Error(); // 에러 발생 Test
  //   if (text?.length == 6) return [];     // 검색 결과 없음 Test
  //
  //   List<Post> posts = [];
  //   var random = Random();
  //   for (int i = 0; i < 4; i++) {
  //     posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
  //   }
  //   return posts;
  // }
}