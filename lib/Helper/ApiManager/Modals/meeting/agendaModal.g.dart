// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendaModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agenda _$AgendaModalFromJson(Map<String, dynamic> json) => Agenda(
      json['description'] as String?,
      json['name'] as String?,
      json['duration'] as String?,
      json['_id'] as String?,
    );

Map<String, dynamic> _$AgendaModalToJson(Agenda instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'duration': instance.duration,
      'description': instance.description,
    };
