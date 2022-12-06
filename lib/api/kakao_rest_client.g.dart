// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kakao_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dapi.kakao.com/v2/search';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<KakaoData> getImageDatas(
    query,
    size,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'size': size,
      r'page': page,
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<KakaoData>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/image',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = KakaoData.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
