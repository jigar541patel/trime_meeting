

import 'package:Trime/Helper/ApiManager/Modals/meeting/MeetingResponse.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MeetingDetail.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingDetails {
  bool status;
  MeetingResponse response;
  MeetingDetails(this.response, this.status);

  factory MeetingDetails.fromJson(Map<String, dynamic> json) =>
      _$MeetingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingDetailsToJson(this);
}
