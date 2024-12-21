// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linkedmeetingModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

linked_meeting _$linked_meetingModalFromJson(Map<String, dynamic> json) =>
    linked_meeting(
      json['description'] as String?,
      json['_id'] as String?,
    )..date = json['date'] as String?;

Map<String, dynamic> _$linked_meetingModalToJson(linked_meeting instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'description': instance.description,
    };
