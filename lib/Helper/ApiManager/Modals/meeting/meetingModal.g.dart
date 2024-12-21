// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetingModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingModal _$MeetingModalFromJson(Map<String, dynamic> json) => MeetingModal(
      (json['response'] as List<dynamic>)
          .map((e) => MeetingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as bool,
    );

Map<String, dynamic> _$MeetingModalToJson(MeetingModal instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response.map((e) => e.toJson()).toList(),
    };
