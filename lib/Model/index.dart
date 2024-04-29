import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable()
class ConvertedFile {
  int converted_id;
  int user_id;
  int uploaded_id;
  String img_url;
  String text;

  ConvertedFile({
    required this.converted_id,
    required this.user_id,
    required this.uploaded_id,
    required this.img_url,
    required this.text,
  });
  
  static List<ConvertedFile> fromList(List<dynamic> data) =>
      data.map((e) => ConvertedFile.fromJson(e)).toList();

  factory ConvertedFile.fromJson(Map<String, dynamic> json) =>_$ConvertedFileFromJson(json);
  Map<String, dynamic> toJson() => _$ConvertedFileToJson(this);
}
