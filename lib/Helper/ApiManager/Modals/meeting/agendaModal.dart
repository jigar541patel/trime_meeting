import 'package:json_annotation/json_annotation.dart';
part 'agendaModal.g.dart';

@JsonSerializable()
class Agenda {
  String? id;
  String? name;
  String? duration;
   String? description;
  
  Agenda(this.description, this.name, this.duration,this.id);

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaModalFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaModalToJson(this);

  compareTo(Agenda value1) {}
}
