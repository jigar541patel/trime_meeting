class ProfileModel {
  bool? status;
  String? message;
  

  ProfileModel({this.status, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}