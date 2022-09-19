import 'package:json_annotation/json_annotation.dart';

part 'AddTaskRequest.g.dart';

@JsonSerializable()
class AddTaskRequest {
  String name;
  DateTime deadline;

  AddTaskRequest(this.name, this.deadline);

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);


}




