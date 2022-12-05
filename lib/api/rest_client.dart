import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// import 'data.dart';
import 'kakao_image.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://dapi.kakao.com/v2/search')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // @GET('/image/{query}')
  // Future<KakaoImage> getImageDatas({
  //   @Path() required String search_name,
  //   // @Path() size search_name,
  //   // @Path() page search_name,
  // });

  // @GET("/image/{id}")
  // Future<KakaoImage> getImageDatas1(
  //     @Path("query") String query,
  //     @Path("size") int size,
  //     );

  /// ---------------------------------- 수정 후

  // @GET('/image')
  // Future<KakaoImage> getImageDatas(
  //     @Query("query") String query,
  //     @Query("size") int size,
  //     @Query("page") int page,
  //     );

  @GET('/image')
  Future<Map<String, List<KakaoImage>>> getImageDatas(
      @Query("query") String query,
      @Query("size") int size,
      @Query("page") int page,
      );
}