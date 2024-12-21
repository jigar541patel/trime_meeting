// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ownerIdModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ownerId _$ownerIdFromJson(Map<String, dynamic> json) => ownerId(
      json['image'] as String?,
      json['email'] as String?,
      json['name'] as String?,
      json['_id'] as String?,
      json['status'] as bool?,
    );

Map<String, dynamic> _$ownerIdToJson(ownerId instance) => <String, dynamic>{
      'image': instance.image,
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'status': instance.status,
    };
