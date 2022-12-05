// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kakao_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KakaoImage _$KakaoImageFromJson(Map<String, dynamic> json) => KakaoImage(
      documents: Documents.fromJson((json['documents'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList()),
    );

Map<String, dynamic> _$KakaoImageToJson(KakaoImage instance) =>
    <String, dynamic>{
      'documents': instance.documents,
    };

Documents _$DocumentsFromJson(Map<String, dynamic> json) => Documents(
      collection: json['collection'] as String,
      datetime: json['datetime'] as String,
      display_sitename: json['display_sitename'] as String,
      doc_url: json['doc_url'] as String,
      image_url: json['image_url'] as String,
      thumbnail_url: json['thumbnail_url'] as String,
      height: json['height'] as int,
      width: json['width'] as int,
    );

Map<String, dynamic> _$DocumentsToJson(Documents instance) => <String, dynamic>{
      'collection': instance.collection,
      'datetime': instance.datetime,
      'display_sitename': instance.display_sitename,
      'doc_url': instance.doc_url,
      'image_url': instance.image_url,
      'thumbnail_url': instance.thumbnail_url,
      'height': instance.height,
      'width': instance.width,
    };
