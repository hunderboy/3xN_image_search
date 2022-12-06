import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


import 'kakao_data.dart';

part 'kakao_rest_client.g.dart';

@RestApi(baseUrl: 'https://dapi.kakao.com/v2/search')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/image')
  Future<KakaoData> getImageDatas(
      @Query("query") String query,
      @Query("size") int size,
      @Query("page") int page,
  );
}