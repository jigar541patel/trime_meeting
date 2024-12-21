import 'package:json_annotation/json_annotation.dart';
part 'taskModal.g.dart';

@JsonSerializable()
class Task {
  String? id;
  String? description;
  String? date;
  List<String> tags;
  Task(this.description, this.date, this.tags,this.id);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskModalFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModalToJson(this);

  compareTo(Task value1) {}
}
