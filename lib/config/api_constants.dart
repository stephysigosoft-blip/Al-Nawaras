class ApiConstants {
  static const String baseUrl =
      'https://rta-parking-staging-29068867.dev.odoo.com/api/';

  // Auth
  static const String login = '${baseUrl}login';
  static const String register = '${baseUrl}register';
  static const String checkUser = '${baseUrl}check_user';
  static const String forgotPassword = '${baseUrl}forgot-password';
  
  // Profile
  static const String profile = '${baseUrl}profile';
  static const String updateprofile = '${baseUrl}profile/update';


  static const String sendOtp = '${baseUrl}forgot_password/send_otp';
  static const String verifyOtp = '${baseUrl}forgot_password/verify_otp';

  // Home
  static const String home = '${baseUrl}home';
}

