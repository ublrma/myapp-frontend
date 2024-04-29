// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertedFile _$ConvertedFileFromJson(Map<String, dynamic> json) =>
    ConvertedFile(
      converted_id: (json['convert_id'] as num).toInt(),
      user_id: (json['user_id'] as num).toInt(),
      uploaded_id: (json['uploaded_id'] as num).toInt(),
      img_url: json['img_url'] as String,
      text: json['converted_text'] as String,
    );

Map<String, dynamic> _$ConvertedFileToJson(ConvertedFile instance) =>
    <String, dynamic>{
      'converted_id': instance.converted_id,
      'user_id': instance.user_id,
      'uploaded_id': instance.uploaded_id,
      'img_url': instance.img_url,
      'text': instance.text,
    };
