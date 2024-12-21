// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MeetingResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingResponse _$MeetingResponseFromJson(Map<String, dynamic> json) =>
    MeetingResponse(
      json['_id'] as String,
      (json['participants'] as List<dynamic>)
          .map((e) => Participants.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meet_ref'] as String,
      ownerId.fromJson(json['owner_id'] as Map<String, dynamic>),
      json['trime'] as bool,
      json['date'] as String,
      json['description'] as String,
      json['duration'] as int,
      json['time'] as String,
      json['conference'] == null
          ? null
          : conferences.fromJson(json['conference'] as Map<String, dynamic>),
      json['mom_sent'] as bool,
      (json['watchers'] as List<dynamic>?)
          ?.map((e) => Watchers.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['task'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['doucements'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['links'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['reccuring'] as String?,
    )..days = json['days'] as String?;

Map<String, dynamic> _$MeetingResponseToJson(MeetingResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'meet_ref': instance.meet_ref,
      'trime': instance.trime,
      'date': instance.date,
      'days': instance.days,
      'description': instance.description,
      'reccuring': instance.reccuring,
      'duration': instance.duration,
      'time': instance.time,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'watchers': instance.watchers?.map((e) => e.toJson()).toList(),
      'task': instance.task?.map((e) => e.toJson()).toList(),
      'doucements': instance.doucements?.map((e) => e.toJson()).toList(),
      'links': instance.links,
      'owner_id': instance.owner_id.toJson(),
      'conference': instance.conference?.toJson(),
      'mom_sent': instance.mom_sent,
    };
