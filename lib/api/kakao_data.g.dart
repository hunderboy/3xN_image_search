// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kakao_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KakaoData _$KakaoDataFromJson(Map<String, dynamic> json) => KakaoData(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => KImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KakaoDataToJson(KakaoData instance) => <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      total_count: json['total_count'] as int,
      pageable_count: json['pageable_count'] as int,
      is_end: json['is_end'] as bool,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'total_count': instance.total_count,
      'pageable_count': instance.pageable_count,
      'is_end': instance.is_end,
    };

Documents _$DocumentsFromJson(Map<String, dynamic> json) => Documents(
      imageList: (json['imageList'] as List<dynamic>)
          .map((e) => KImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentsToJson(Documents instance) => <String, dynamic>{
      'imageList': instance.imageList,
    };

KImage _$KImageFromJson(Map<String, dynamic> json) => KImage(
      collection: json['collection'] as String,
      datetime: json['datetime'] as String,
      display_sitename: json['display_sitename'] as String,
      doc_url: json['doc_url'] as String,
      image_url: json['image_url'] as String,
      thumbnail_url: json['thumbnail_url'] as String,
      height: json['height'] as int,
      width: json['width'] as int,
    );

Map<String, dynamic> _$KImageToJson(KImage instance) => <String, dynamic>{
      'collection': instance.collection,
      'datetime': instance.datetime,
      'display_sitename': instance.display_sitename,
      'doc_url': instance.doc_url,
      'image_url': instance.image_url,
      'thumbnail_url': instance.thumbnail_url,
      'height': instance.height,
      'width': instance.width,
    };
