import 'package:json_annotation/json_annotation.dart';

part 'documentModal.g.dart';

@JsonSerializable()
class Document{
  String? image;
  Document(this.image);


  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentModalFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModalToJson(this);

  compareTo(Document value1) {}
}