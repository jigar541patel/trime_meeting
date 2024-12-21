class loginModel {
  bool? status;
  String? message;
  

  loginModel({this.status, this.message});

  loginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
