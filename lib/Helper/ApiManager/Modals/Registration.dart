class registrationModal {
  bool? status;
  String? message;

  registrationModal({this.status, this.message});

  registrationModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}