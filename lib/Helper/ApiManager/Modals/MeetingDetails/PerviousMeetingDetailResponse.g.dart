// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PerviousMeetingDetailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerviousMeetingDetailResponse _$PerviousMeetingDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PerviousMeetingDetailResponse(
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
      (json['agenda'] as List<dynamic>?)
          ?.map((e) => Agenda.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['documents'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['links'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['note'] as String?,
      (json['contact_participants'] as List<dynamic>?)
          ?.map((e) => contactparticipants.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['guest_watchers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['contact_watchers'] as List<dynamic>?)
          ?.map((e) => contactwatchers.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['guest_participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['status'] as String?,
      (json['agenda_note'] as List<dynamic>?)
          ?.map((e) => agendaNotes.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['linked_meeting'] as List<dynamic>?)
          ?.map((e) => linked_meeting.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['recordinglink'] as String?,
    )..days = json['days'] as String?;

Map<String, dynamic> _$PerviousMeetingDetailResponseToJson(
        PerviousMeetingDetailResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'meet_ref': instance.meet_ref,
      'trime': instance.trime,
      'date': instance.date,
      'status': instance.status,
      'days': instance.days,
      'description': instance.description,
      'recordinglink': instance.recordinglink,
      'duration': instance.duration,
      'time': instance.time,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'watchers': instance.watchers?.map((e) => e.toJson()).toList(),
      'task': instance.task?.map((e) => e.toJson()).toList(),
      'agenda': instance.agenda?.map((e) => e.toJson()).toList(),
      'documents': instance.documents,
      'links': instance.links,
      'owner_id': instance.owner_id.toJson(),
      'conference': instance.conference?.toJson(),
      'mom_sent': instance.mom_sent,
      'note': instance.note,
      'contact_participants':
          instance.contactparticipant?.map((e) => e.toJson()).toList(),
      'guest_watchers': instance.guestwatchers,
      'contact_watchers':
          instance.contactwatcher?.map((e) => e.toJson()).toList(),
      'guest_participants': instance.guestparticipants,
      'agenda_note': instance.agendaNote?.map((e) => e.toJson()).toList(),
      'linked_meeting': instance.linkedmeeting?.map((e) => e.toJson()).toList(),
    };
