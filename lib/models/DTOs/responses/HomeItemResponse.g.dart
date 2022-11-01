// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeItemResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeItemResponse _$HomeItemResponseFromJson(Map<String, dynamic> json) =>
    HomeItemResponse(
      json['id'] as int,
      json['name'] as String,
      json['percentageDone'] as int,
      (json['percentageTimeSpent'] as num).toDouble(),
      DateTime.parse(json['deadline'] as String),
      json['photoId'] as int,
    );

Map<String, dynamic> _$HomeItemResponseToJson(HomeItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': instance.deadline.toIso8601String(),
      'photoId': instance.photoId,
    };
