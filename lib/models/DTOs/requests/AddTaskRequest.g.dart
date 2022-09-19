// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddTaskRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) =>
    AddTaskRequest(
      json['name'] as String,
      DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadline': instance.deadline.toIso8601String(),
    };
