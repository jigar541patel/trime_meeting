import 'package:json_annotation/json_annotation.dart';
part 'watchersModal.g.dart';

@JsonSerializable()
class Watchers{
  String? image;
   String? email;
  
   
  Watchers(this.image,this.email);


  factory Watchers.fromJson(Map<String, dynamic> json) =>
      _$WatchersModalFromJson(json);

  Map<String, dynamic> toJson() => _$WatchersModalToJson(this);

  compareTo(Watchers value1) {}
}