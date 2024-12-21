//agendaNotesModal
import 'package:json_annotation/json_annotation.dart';
part 'agendaNotesModal.g.dart';

@JsonSerializable()
class agendaNotes {
  String? agenda_id;
  String? note;
  
  
  agendaNotes(this.note,this.agenda_id);

  factory agendaNotes.fromJson(Map<String, dynamic> json) => _$agendaNotesModalFromJson(json);

  Map<String, dynamic> toJson() => _$agendaNotesModalToJson(this);

  compareTo(agendaNotes value1) {}
}
