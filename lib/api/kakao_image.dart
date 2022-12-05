import 'package:json_annotation/json_annotation.dart';

part 'kakao_image.g.dart';

@JsonSerializable()
class KakaoImage {
  Documents documents;

  KakaoImage({
    required this.documents,
  });

  /// 수정전
  // factory KakaoImage.fromJson(Map<String, dynamic> json) => _$KakaoImageFromJson(json);
  // Map<String, dynamic> toJson() => _$KakaoImageToJson(this);
  /// 수정 후
  factory KakaoImage.fromJson(List<Map<String, dynamic>> json) => _$KakaoImageFromJson(json);
  List<Map<String, dynamic>> toJson() => _$KakaoImageToJson(this);
}

@JsonSerializable()
class Documents {
  Documents({
    required this.collection,
    // required this.datetime,
    // required this.display_sitename,
    // required this.doc_url,
    // required this.image_url,
    // required this.thumbnail_url,
    // required this.height,
    // required this.width,
  });


  // "collection": "news",
  // "datetime": "2022-11-22T09:25:04.000+09:00",
  // "display_sitename": "스포츠경향",
  // "doc_url": "http://v.media.daum.net/v/20221122092504737",
  // "image_url": "https://t1.daumcdn.net/news/202211/22/sportskhan/20221122092506678lkoc.png",
  // "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/9ckITd9jCVl",
  // "height": 1174,
  // "width": 700
  @JsonKey(name: 'collection')
  String collection;
  // @JsonKey(name: 'datetime')
  // String datetime;
  // @JsonKey(name: 'display_sitename')
  // String display_sitename;
  // @JsonKey(name: 'doc_url')
  // String doc_url;
  // @JsonKey(name: 'image_url')
  // String image_url;
  // @JsonKey(name: 'thumbnail_url')
  // String thumbnail_url;
  // @JsonKey(name: 'height')
  // int height;
  // @JsonKey(name: 'width')
  // int width;

  /// 수정전
  // factory Documents.fromJson(Map<String, dynamic> json) => _$DocumentsFromJson(json);
  // Map<String, dynamic> toJson() => _$DocumentsToJson(this);
  /// 수정 후
  factory Documents.fromJson(List<Map<String, dynamic>> json) => _$DocumentsFromJson(json);
  List<Map<String, dynamic>> toJson() => _$DocumentsToJson(this);
}