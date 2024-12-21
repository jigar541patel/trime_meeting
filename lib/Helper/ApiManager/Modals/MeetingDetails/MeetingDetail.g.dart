// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MeetingDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingDetails _$MeetingDetailsFromJson(Map<String, dynamic> json) =>
    MeetingDetails(
      MeetingResponse.fromJson(json['response'] as Map<String, dynamic>),
      json['status'] as bool,
    );

Map<String, dynamic> _$MeetingDetailsToJson(MeetingDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response.toJson(),
    };
