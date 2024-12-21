
import 'package:json_annotation/json_annotation.dart';

part 'linkedmeetingModal.g.dart';

@JsonSerializable()
class linked_meeting {
  String? id;
  String? date;
 
   String? description;
  
  linked_meeting(this.description,this.id);

  factory linked_meeting.fromJson(Map<String, dynamic> json) => _$linked_meetingModalFromJson(json);

  Map<String, dynamic> toJson() => _$linked_meetingModalToJson(this);

  compareTo(linked_meeting value1) {}
}
