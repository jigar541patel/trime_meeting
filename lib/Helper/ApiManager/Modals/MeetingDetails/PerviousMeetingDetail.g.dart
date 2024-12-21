// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PerviousMeetingDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerviousMeetingDetail _$PerviousMeetingDetailFromJson(
        Map<String, dynamic> json) =>
    PerviousMeetingDetail(
      PerviousMeetingDetailResponse.fromJson(
          json['response'] as Map<String, dynamic>),
      json['status'] as bool,
    );

Map<String, dynamic> _$PerviousMeetingDetailToJson(
        PerviousMeetingDetail instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response.toJson(),
    };
