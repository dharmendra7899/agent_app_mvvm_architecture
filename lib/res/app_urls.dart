
class AppUrls {
  static String get baseUrl => 'http://13.202.67.35:8200/api';

  static String get socketUrl => 'ws://13.61.83.27:5002';
  static String get razorPayKey => 'rzp_test_Y18ZHuyYBnqQ7z';

  ///authentication apis end points
  static String get loginEndPoint => '/usersignin';
  static String get registerEndPoint =>"/usersignup";
  static String get accountDeleteEndPoint =>'/accountDelete';
  static String get forgetPasswordEndPoint => '/forgotPassword';
  static String get verifyEmailEndPoint =>'/verifyEmail';
  static String get resendOTPEndPoint =>'/resendVerifyEmailCode';
  static String get updatePasswordEndPoint =>'/updatePassword';
///dashboard apis end points
  static String get homeBannerEndPoints =>'/homeBanner';
}
