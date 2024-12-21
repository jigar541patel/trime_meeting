//PerviousMeetingDetailResponse
import 'package:Trime/Helper/ApiManager/Modals/MeetingDetails/conferenceModel.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/agendaModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/agendaNotesModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/contactparticipantsModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/contactwatchersModal.dart';

import 'package:Trime/Helper/ApiManager/Modals/meeting/documentModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/linkedmeetingModal.dart';

import 'package:Trime/Helper/ApiManager/Modals/meeting/ownerIdModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/participantModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/taskModal.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/watchersModal.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PerviousMeetingDetailResponse.g.dart';

@JsonSerializable(explicitToJson: true)
class PerviousMeetingDetailResponse {
  String id;
  String meet_ref;
  bool trime;
  String date;
  String? status;
  String? days = "Upcoming Meeting";
  String description;
  String? recordinglink;
  int duration;
  String time;
  List<Participants> participants;
  List<Watchers>? watchers;
  List<Task>? task;
  List<Agenda>? agenda;
  List<String>? documents;
  List<String>? links;
  ownerId owner_id;
  conferences? conference;
  bool mom_sent;
  String? note;
  List<contactparticipants>? contactparticipant;
  List<String>? guestwatchers;
  List<contactwatchers>? contactwatcher;
  List<String>? guestparticipants;
  List<agendaNotes>? agendaNote;
  List<linked_meeting>? linkedmeeting;
  PerviousMeetingDetailResponse(
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
      this.agenda,
      this.documents,
      this.links,
      this.note,
      this.contactparticipant,
      this.guestwatchers,
      this.contactwatcher,
      this.guestparticipants,
      this.status,
      this.agendaNote,this.linkedmeeting,this.recordinglink);

  factory PerviousMeetingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PerviousMeetingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PerviousMeetingDetailResponseToJson(this);

  compareTo(PerviousMeetingDetailResponse value1) {}
}
