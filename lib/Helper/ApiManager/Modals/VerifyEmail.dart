class VerifyEmailId {
  bool? status;
  String? message;
  

  VerifyEmailId({this.status, this.message});

  VerifyEmailId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}