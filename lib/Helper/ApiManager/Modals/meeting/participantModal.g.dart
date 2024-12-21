// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participantModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participants _$ParticipantsFromJson(Map<String, dynamic> json) => Participants(
      json['image'] as String?,
      json['email'] as String?,
      json['_id'] as String?,
      json['status'] as bool?,
    );

Map<String, dynamic> _$ParticipantsToJson(Participants instance) =>
    <String, dynamic>{
      'image': instance.image,
      '_id': instance.id,
      'email': instance.email,
      'status': instance.status,
    };
