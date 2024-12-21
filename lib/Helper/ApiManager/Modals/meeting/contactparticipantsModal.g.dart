// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactparticipantsModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

contactparticipants _$contactparticipantsModalFromJson(Map<String, dynamic> json) =>
    contactparticipants(
      json['name'] as String?,
      json['email'] as String?,
      json['_id'] as String?,
    );

Map<String, dynamic> _$contactparticipantsModalToJson(
        contactparticipants instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
