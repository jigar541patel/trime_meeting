//PerviousMeetingDetail
import 'package:Trime/Helper/ApiManager/Modals/meeting/MeetingResponse.dart';
import 'package:json_annotation/json_annotation.dart';

import 'PerviousMeetingDetailResponse.dart';
part 'PerviousMeetingDetail.g.dart';

@JsonSerializable(explicitToJson: true)
class PerviousMeetingDetail {
  bool status;
  PerviousMeetingDetailResponse response;
  PerviousMeetingDetail(this.response, this.status);

  factory PerviousMeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$PerviousMeetingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PerviousMeetingDetailToJson(this);
}
