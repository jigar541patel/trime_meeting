import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:Trime/Helper/ApiManager/Modals/MeetingDetails/MeetingDetail.dart';
import 'package:Trime/Helper/ApiManager/Modals/VerifyEmail.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/meetingModal.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:Trime/Helper/ApiManager/Modals/Registration.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'Modals/MeetingDetails/PerviousMeetingDetail.dart';

class ApiManager {
  static Dio dio = Dio();

  static Future<registrationModal?> registrationApi(Map parameters) async {
    try {
      var response = await dio.post(Url.registerApi, data: parameters);

      log("response search data ${response.data}");
      return registrationModal.fromJson(response.data);
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> signinJaasToken(Map parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.post(Url.signJassToken,
          data: parameters, options: Options(headers: paramter));

      log("response search data ${response.data}");
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> loginApi(Map parameters) async {
    try {
      var response = await dio.post(Url.loginApi, data: parameters);

      log("response search data ${response.data}");
      // return loginModel.fromJson(response.data);
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<VerifyEmailId?> VerifyApi(Map parameters) async {
    try {
      var response = await dio.post(Url.verifyApi, data: parameters);

      log("response search data ${response.data}");
      return VerifyEmailId.fromJson(response.data);
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic?> mfaVerify(Map parameters) async {
    try {
      var response = await dio.post(Url.mfaApi, data: parameters);

      log("response search data ${response.data}");
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> LinkSend(Map parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.post(Url.sendLink,
          data: parameters, options: Options(headers: paramter));

      log("response search data ${response.data}");
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> getNotification(Map parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};

    try {
      var response = await dio.post(Url.getNotificatsion,
          data: parameters, options: Options(headers: paramter));

      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> ForgetPasswordApi(Map parameters) async {
    try {
      var response = await dio.post(Url.forgetPasswordApi, data: parameters);

      log("response search data ${response.data}");
      // return ForgetPasswordwithEmail.fromJson(response.data);
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

// headers: {"appusertoken": "$htoken"},
  static Future<dynamic> UpdatePasswordApiwithOTP(Map parameters) async {
    try {
      var response = await dio.post(Url.updatePasswordApi, data: parameters);

      log("response search data ${response.data}");
      // return ForgetPasswordwithEmail.fromJson(response.data);
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> getProfile(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.post(Url.getProfileApi,
          data: parameters, options: Options(headers: paramter));

      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> updateProfile(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.post(Url.updateProfileApi,
          data: parameters, options: Options(headers: paramter));

      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> uploadProfileImage(File filepath, oldpath) async {
    String fileName = filepath.path
        .split('/')
        .last;
    String id = await sharePrefrence.getString("userId");
    String token = await sharePrefrence.getString("token");
    FormData formData = FormData.fromMap({
      "user_id": MultipartFile.fromString(id),
      "avatar": await MultipartFile.fromFile(filepath.path, filename: fileName)
    });
    var paramter = {"Authorization": token};
    try {
      var response = await dio.post(Url.UpdateProfileImage,
          data: formData, options: Options(headers: paramter));
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> changePasswordApi(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.post(Url.changePassword,
          data: parameters, options: Options(headers: paramter));
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> postUpdateProfileImage(File _image, oldpath) async {
    String token = await sharePrefrence.getString("token");
    String id = await sharePrefrence.getString("userId");

    var request =
    http.MultipartRequest('POST', Uri.parse(Url.UpdateProfileImage));

    request.files.add(
      http.MultipartFile(
          'avatar', _image.readAsBytes().asStream(), _image.lengthSync(),
          filename: _image.path
              .split('/')
              .last),
    );
    request.files.add(http.MultipartFile.fromString("user_id", "$id"));

    request.headers.addAll({
      'Authorization': token,
    });

    // request.fields.addAll(parameterMap);

    final responseStreamed = await request.send();

    final response = await responseStreamed.stream.bytesToString();
    var decodeResponse = json.decode(response);
    return decodeResponse;
    // print('Request: Sign In :${request.url} || $parameterMap >> $response');
  }

  static Future<MeetingModal?> GetMeetingUpcoming(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token, "Content-Type": "application/json"};
    try {
      var response = await dio.post(Url.GetUpComingMeeting,
          data: parameters, options: Options(headers: paramter));

      debugPrint("trime the request header .toString() " +
          response.headers.toString());



    return MeetingModal.fromJson(response.data);
    } on DioError catch (e) {
    log("Exception in loginUser = ${e.error}");
    return await handleErrors(e);
    }
  }

  static Future<dynamic> deleteMeeting(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token, "Content-Type": "application/json"};
    try {
      var response = await dio.post(Url.deleteMeeting,
          data: parameters, options: Options(headers: paramter));
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> privateNote(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token, "Content-Type": "application/json"};
    try {
      var response = await dio.post(Url.getPrivateNote,
          data: parameters, options: Options(headers: paramter));
      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

//PerviousMeetingDetail
  static Future<PerviousMeetingDetail?> GetPerivousMeetingDetailsById(
      url) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.get(url, options: Options(headers: paramter));

      return PerviousMeetingDetail.fromJson(response.data);
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<PerviousMeetingDetail?> GetMeetingById(url) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token};
    try {
      var response = await dio.get(url, options: Options(headers: paramter));

      return PerviousMeetingDetail.fromJson(response.data);
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<MeetingModal?> GetMeetingPrevious(parameters) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token, "Content-Type": "application/json"};
    debugPrint("trime the url is " + Url.PreiviousMeeting);
    debugPrint("trime the parameter is " + paramter.toString());
    debugPrint("trime the parameters we have is " + parameters.toString());

    try {
      var response = await dio.post(Url.PreiviousMeeting,
          data: parameters, options: Options(headers: paramter));
      debugPrint("trime the response we have is " + response.toString());
      return MeetingModal.fromJson(response.data);
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic?> GetMeetingComplete(dynamic id) async {
    var token = await sharePrefrence.getString("token");
    var paramter = {"Authorization": token, "Content-Type": "application/json"};

    try {
      var response = await dio.post(Url.CompleteMeeting + id,
          options: Options(headers: paramter));

      return response.data;
    } on DioError catch (e) {
      log("Exception in loginUser = ${e.error}");
      return await handleErrors(e);
    }
  }

  static Future<dynamic> handleErrors(e) {
    if (e.type == DioErrorType.response) {
      return Future.error("Something went wrong");
    } else if (e.type == DioErrorType.receiveTimeout) {
      return Future.error("Took longer to load !");
    } else if (e.type == DioErrorType.other) {
      if (e.message.contains('SocketException')) {
        return Future.error("No Internet Connection");
      } else {
        return Future.error("Something went wrong");
      }
    } else {
      return Future.error("Something went wrong");
    }
  }
}
