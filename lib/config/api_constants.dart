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

  // Parking
  static const String locationDetails = '${baseUrl}parking/location_details';
  static const String slotDetails = '${baseUrl}parking/slot_details';
  static const String confirmLocation = '${baseUrl}parking/confirm_location';

  // Memberships
  static const String memberships = '${baseUrl}memberships';

  // Additional Services
  static const String services = '${baseUrl}services';

  // Booking History
  static const String parkingHistory = '${baseUrl}parking/history';

  // Rewards
  static const String rewards = '${baseUrl}rewards';

  // Vehicles
  static const String vehicles = '${baseUrl}vehicles';

  /// fetch vehicle details

  // Vehicle Types
  static const String vehicleTypes = '${baseUrl}vehicle_types';

  // Settings
  static const String settings = '${baseUrl}settings';
}
