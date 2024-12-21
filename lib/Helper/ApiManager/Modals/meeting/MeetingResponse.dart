import 'package:Trime/Helper/ApiManager/Modals/MeetingDetails/conferenceModel.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/agendaModal.dart';

import 'package:Trime/Helper/ApiManager/Modals/meeting/documentModal.dart';

import 'package:Trime/Helper/ApiManager/Modals/meeting/ownerIdModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/participantModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/taskModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/watchersModal.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MeetingResponse.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingResponse {
  String id;
  String meet_ref;
  bool trime;
  String date;
  String? days = "Upcoming Meeting";
  String description;
  String? reccuring;
  int duration;
  String time;
  List<Participants> participants;
  List<Watchers>? watchers;
  List<Task>? task;
  //List<Agenda>? agenda;
  List<Document>? doucements;
  List<String>? links;
  ownerId owner_id;
  conferences? conference;
  bool mom_sent;

  MeetingResponse(
      this.id,
      this.participants,
      this.meet_ref,
      this.owner_id,
      this.trime,
      this.date,
      this.description,
      this.duration,
      this.time,
      this.conference,
      this.mom_sent,
      this.watchers,
      this.task,
      // this.agenda,
      this.doucements,
      this.links,this.reccuring);

  factory MeetingResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingResponseToJson(this);

  compareTo(MeetingResponse value1) {}
}
