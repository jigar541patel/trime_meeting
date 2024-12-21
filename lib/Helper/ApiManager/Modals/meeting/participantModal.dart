import 'package:json_annotation/json_annotation.dart';
part 'participantModal.g.dart';

@JsonSerializable()
class Participants{
  String? image;
  String? id;
  String? email;
  bool? status;
  Participants(this.image, this.email, this.id, this.status);

   factory Participants.fromJson(Map<String, dynamic> json) =>
      _$ParticipantsFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantsToJson(this);
}