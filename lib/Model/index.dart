import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable()
class ZarModel {
  String zar_id;
  String driver_id;
  String haanaas_aimag;
  String haanaas_sum;
  String haashaa_aimag;
  String haashaa_sum;
  String udur;
  String tsag;
  int zorchigch_too;
  int purchased_too;
  int adult_price;
  int child_price;
  int driver_is_arrived;
  String L_name;
  String F_name;
  ZarModel({
    required this.zar_id,
    required this.driver_id,
    required this.haanaas_aimag,
    required this.haanaas_sum,
    required this.haashaa_aimag,
    required this.haashaa_sum,
    required this.udur,
    required this.tsag,
    required this.zorchigch_too,
    required this.purchased_too,
    required this.adult_price,
    required this.child_price,
    required this.driver_is_arrived,
    required this.L_name,
    required this.F_name,
  });

  static List<ZarModel> fromList(List<dynamic> data) =>
      data.map((e) => ZarModel.fromJson(e)).toList();

  factory ZarModel.fromJson(Map<String, dynamic> json) =>
      _$ZarModelFromJson(json);
  Map<String, dynamic> toJson() => _$ZarModelToJson(this);
}
