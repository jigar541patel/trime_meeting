class UpdatePassword {
  bool? status;
  String? message;
  List<responseModal>? response;
  UpdatePassword({this.status, this.message, this.response});

  UpdatePassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = <responseModal>[];
      json['response'].forEach((v) {
        response!.add(new responseModal.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class responseModal {
  String? id;
  String? email;
  responseModal({this.id, this.email});

  responseModal.fromJson(Map<String, String> json) {
    id = json["_id"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['_id'] = this.id;
    return data;
  }
}
