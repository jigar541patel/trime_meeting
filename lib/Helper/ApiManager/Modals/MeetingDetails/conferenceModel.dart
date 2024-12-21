
import 'package:json_annotation/json_annotation.dart';
part 'conferenceModel.g.dart';
@JsonSerializable()
class conferences {
  String type;
  String? jitsiMeeting;

  conferences(this.type, this.jitsiMeeting);

  factory conferences.fromJson(Map<String, dynamic> json) =>
      _$conferencesFromJson(json);

  Map<String, dynamic> toJson() => _$conferencesToJson(this);
}
