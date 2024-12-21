class Url {
  //live url = https://app.trime.ai/
  //staging url = https://staging.trime.ai/
  static var ImageUrl = "https://staging.trime.ai/user/";
  static var fileurl = "https://staging.trime.ai/document/meeting/";
  static var webViewUrl = "https://staging.trime.ai/";
  static var BaseUrl = "https://staging.trime.ai/api/";
  static String registerApi = BaseUrl + "user/register";
  static String loginApi = BaseUrl + "user/login";
  static String mfaApi = BaseUrl + "user/loginWithMFAOTP";
  static String verifyApi = BaseUrl + "user/verifyMail";
  static String forgetPasswordApi = BaseUrl + "user/getOTPwithEmail";
  static String updatePasswordApi = BaseUrl + "user/updatePassword";
  static String getProfileApi = BaseUrl + "user/getProfile";
  static String updateProfileApi = BaseUrl + "user/updateProfile";
  static String UpdateProfileImage = BaseUrl + "user/changeProfileImage";
  static String changePassword = BaseUrl + "user/changePassword";
  static String MeetingById = BaseUrl + 'meeting/';
  static String GetUpComingMeeting = BaseUrl + 'meeting/getMeetings/upcoming';
  static String PreiviousMeeting = BaseUrl + 'meeting/getMeetings/previous';
  static String CompleteMeeting = BaseUrl + 'meeting/completeMeeting/';
  static String signJassToken = BaseUrl + "meeting/signJaasToken";
  static String sendLink = BaseUrl + "meeting/sendMOM";
  static String deleteMeeting = BaseUrl + "meeting/removeMeeting";
  static String getPrivateNote = BaseUrl + "meeting/getPrivateNote";
  static String getNotificatsion = BaseUrl + "notification/registerFCMToken";
  static String termsconditionUrl = webViewUrl + "terms-condition";
  static String privacypolicyUrl = webViewUrl + "privacy-policy";
  static String notificationTypeUrl =
      webViewUrl + "notification/getNotifications";

// https://staging.trime.ai/api/meeting/getMeetings/upcoming
}
