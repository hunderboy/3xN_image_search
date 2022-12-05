import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// import 'data.dart';
import 'kakao_image.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://dapi.kakao.com/v2/search')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/image/{query}')
  Future<KakaoImage> getImageDatas({
    @Path() required query search_name,
    @Path() size search_name,
    @Path() page search_name,
  });
}