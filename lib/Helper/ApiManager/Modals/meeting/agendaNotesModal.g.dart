// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendaNotesModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

agendaNotes _$agendaNotesModalFromJson(Map<String, dynamic> json) => agendaNotes(
      json['note'] as String?,
      json['agenda_id'] as String?,
    );

Map<String, dynamic> _$agendaNotesModalToJson(agendaNotes instance) =>
    <String, dynamic>{
      'agenda_id': instance.agenda_id,
      'note': instance.note,
    };
