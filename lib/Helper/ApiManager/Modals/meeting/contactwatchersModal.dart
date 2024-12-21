import 'package:json_annotation/json_annotation.dart';
part 'contactwatchersModal.g.dart';

@JsonSerializable()
class contactwatchers {
  String? id;
  String? name;
  String? email;
  
  
  contactwatchers(this.name, this.email,this.id);

  factory contactwatchers.fromJson(Map<String, dynamic> json) => _$contactwatchersModalFromJson(json);

  Map<String, dynamic> toJson() => _$contactwatchersModalToJson(this);

  compareTo(contactwatchers value1) {}
}