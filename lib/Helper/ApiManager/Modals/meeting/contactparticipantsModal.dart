import 'package:json_annotation/json_annotation.dart';
part 'contactparticipantsModal.g.dart';

@JsonSerializable()
class contactparticipants {
  String? id;
  String? name;
  String? email;
  
  
  contactparticipants(this.name, this.email,this.id);

  factory contactparticipants.fromJson(Map<String, dynamic> json) => _$contactparticipantsModalFromJson(json);

  Map<String, dynamic> toJson() => _$contactparticipantsModalToJson(this);

  compareTo(contactparticipants value1) {}
}