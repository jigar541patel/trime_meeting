// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactwatchersModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

contactwatchers _$contactwatchersModalFromJson(Map<String, dynamic> json) =>
    contactwatchers(
      json['name'] as String?,
      json['email'] as String?,
      json['_id'] as String?,
    );

Map<String, dynamic> _$contactwatchersModalToJson(contactwatchers instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
