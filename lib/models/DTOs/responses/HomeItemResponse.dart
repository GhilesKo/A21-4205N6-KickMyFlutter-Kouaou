import 'package:json_annotation/json_annotation.dart';

part 'HomeItemResponse.g.dart';

@JsonSerializable()

class HomeItemResponse {
  late int id;
  late String name;
  late int percentageDone;
  late double percentageTimeSpent;
  late DateTime deadline;

  HomeItemResponse(
    this.id,
    this.name,
    this.percentageDone,
    this.percentageTimeSpent,
    this.deadline,
  );

  factory HomeItemResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);

//TODO: Formatter date si erreur survient.. pour linstant, fonctionne bien.
//https://github.com/departement-info-cem/5N6-mobile-2/blob/master/date_json/lib/dto.dart

}
