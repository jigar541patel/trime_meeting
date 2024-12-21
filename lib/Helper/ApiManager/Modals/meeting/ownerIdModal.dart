import 'package:json_annotation/json_annotation.dart';
part 'ownerIdModal.g.dart';

@JsonSerializable()
class ownerId {
  String? image;
  String? id;
  String? email;
  String? name;
  bool? status;
  ownerId(this.image, this.email, this.name,this.id, this.status);

  factory ownerId.fromJson(Map<String, dynamic> json) =>
      _$ownerIdFromJson(json);

  Map<String, dynamic> toJson() => _$ownerIdToJson(this);
}
