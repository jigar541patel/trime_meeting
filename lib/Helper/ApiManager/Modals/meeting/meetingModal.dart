import 'package:Trime/Helper/ApiManager/Modals/meeting/MeetingResponse.dart';
import 'package:json_annotation/json_annotation.dart';
part 'meetingModal.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingModal {
  bool status;
  List<MeetingResponse> response;
  MeetingModal(this.response, this.status);

  factory MeetingModal.fromJson(Map<String, dynamic> json) =>
      _$MeetingModalFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingModalToJson(this);

  compareTo(MeetingModal value1) {}
}
