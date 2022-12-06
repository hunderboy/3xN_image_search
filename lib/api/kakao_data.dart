import 'package:json_annotation/json_annotation.dart';

part 'kakao_data.g.dart';


@JsonSerializable()
class KakaoData {
  Meta meta;
  List<KImage> documents;

  KakaoData({
    required this.meta,
    required this.documents,
  });

  factory KakaoData.fromJson(Map<String, dynamic> json) => _$KakaoDataFromJson(json);
  Map<String, dynamic> toJson() => _$KakaoDataToJson(this);
}

/// meta 데이터 관련
@JsonSerializable()
class Meta {
  Meta({
    required this.total_count,
    required this.pageable_count,
    required this.is_end,
  });

  @JsonKey(name: 'total_count')
  int total_count;
  @JsonKey(name: 'pageable_count')
  int pageable_count;
  @JsonKey(name: 'is_end')
  bool is_end;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

/// Documents 데이터 관련 : List 선언만 한다. todo[이게 꼭 필요한지 테스트 해봐야 함.]
@JsonSerializable()
class Documents {
  Documents({
    required this.imageList,
  });

  List<KImage> imageList;

  factory Documents.fromJson(Map<String, dynamic> json) => _$DocumentsFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentsToJson(this);
}

/// Documents 속 안에 들어가는 이미지 관련 데이터 선언
@JsonSerializable()
class KImage {
  KImage({
    required this.collection,
    required this.datetime,
    required this.display_sitename,
    required this.doc_url,
    required this.image_url,
    required this.thumbnail_url,
    required this.height,
    required this.width,
  });

  @JsonKey(name: 'collection')
  String collection;
  @JsonKey(name: 'datetime')
  String datetime;
  @JsonKey(name: 'display_sitename')
  String display_sitename;
  @JsonKey(name: 'doc_url')
  String doc_url;
  @JsonKey(name: 'image_url')
  String image_url;
  @JsonKey(name: 'thumbnail_url')
  String thumbnail_url;
  @JsonKey(name: 'height')
  int height;
  @JsonKey(name: 'width')
  int width;

  factory KImage.fromJson(Map<String, dynamic> json) => _$KImageFromJson(json);
  Map<String, dynamic> toJson() => _$KImageToJson(this);
}
