// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskModalFromJson(Map<String, dynamic> json) => Task(
      json['description'] as String?,
      json['date'] as String?,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['_id'] as String?,
    );

Map<String, dynamic> _$TaskModalToJson(Task instance) => <String, dynamic>{
      '_id': instance.id,
      'description': instance.description,
      'date': instance.date,
      'tags': instance.tags,
    };
