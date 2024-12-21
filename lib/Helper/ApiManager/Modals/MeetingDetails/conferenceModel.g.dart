// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conferenceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

conferences _$conferencesFromJson(Map<String, dynamic> json) => conferences(
      json['type'] as String,
      json['jitsiMeeting'] as String?,
    );

Map<String, dynamic> _$conferencesToJson(conferences instance) =>
    <String, dynamic>{
      'type': instance.type,
      'jitsiMeeting': instance.jitsiMeeting,
    };
