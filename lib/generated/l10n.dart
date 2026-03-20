// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Credit`
  String get credit {
    return Intl.message('Credit', name: 'credit', desc: '', args: []);
  }

  /// `Currently no items Found, Please try later...`
  String get currentlyNoItemsFoundPleaseTryLater {
    return Intl.message(
      'Currently no items Found, Please try later...',
      name: 'currentlyNoItemsFoundPleaseTryLater',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get off {
    return Intl.message('OFF', name: 'off', desc: '', args: []);
  }

  /// `Pay`
  String get pay {
    return Intl.message('Pay', name: 'pay', desc: '', args: []);
  }

  /// `points`
  String get points {
    return Intl.message('points', name: 'points', desc: '', args: []);
  }

  /// `No vehicles found`
  String get noVehiclesFound {
    return Intl.message(
      'No vehicles found',
      name: 'noVehiclesFound',
      desc: '',
      args: [],
    );
  }

  /// `Generic Vehicle`
  String get genericVehicle {
    return Intl.message(
      'Generic Vehicle',
      name: 'genericVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Replace`
  String get replace {
    return Intl.message('Replace', name: 'replace', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Premium Parking Solutions`
  String get premiumParkingSolutions {
    return Intl.message(
      'Premium Parking Solutions',
      name: 'premiumParkingSolutions',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Sign in to your account`
  String get signInToYourAccount {
    return Intl.message(
      'Sign in to your account',
      name: 'signInToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email or Mobile`
  String get emailOrMobile {
    return Intl.message(
      'Email or Mobile',
      name: 'emailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email or mobile`
  String get enterEmailOrMobile {
    return Intl.message(
      'Enter your email or mobile',
      name: 'enterEmailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enterPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Or sign in with`
  String get orSignInWith {
    return Intl.message(
      'Or sign in with',
      name: 'orSignInWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your details to create an account`
  String get provideDetailsToRegister {
    return Intl.message(
      'Please provide your details to create an account',
      name: 'provideDetailsToRegister',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enterFullName {
    return Intl.message(
      'Enter your full name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter your mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `+971 XX XXX XXXX`
  String get mobileHint {
    return Intl.message(
      '+971 XX XXX XXXX',
      name: 'mobileHint',
      desc: '',
      args: [],
    );
  }

  /// `Driving License Number (Optional)`
  String get drivingLicense {
    return Intl.message(
      'Driving License Number (Optional)',
      name: 'drivingLicense',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Driving License Number`
  String get enterDrivingLicense {
    return Intl.message(
      'Enter your Driving License Number',
      name: 'enterDrivingLicense',
      desc: '',
      args: [],
    );
  }

  /// `Create a password`
  String get createPassword {
    return Intl.message(
      'Create a password',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the Terms of Service and Privacy Policy`
  String get agreeToTerms {
    return Intl.message(
      'I agree to the Terms of Service and Privacy Policy',
      name: 'agreeToTerms',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Secure parking for caravans, jet skis, \nfood trucks, boats and more`
  String get welcomeDescription {
    return Intl.message(
      'Secure parking for caravans, jet skis, \nfood trucks, boats and more',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Renew`
  String get renew {
    return Intl.message('Renew', name: 'renew', desc: '', args: []);
  }

  /// `Book Parking`
  String get bookParking {
    return Intl.message(
      'Book Parking',
      name: 'bookParking',
      desc: '',
      args: [],
    );
  }

  /// `Request Service`
  String get requestService {
    return Intl.message(
      'Request Service',
      name: 'requestService',
      desc: '',
      args: [],
    );
  }

  /// `Membership Plans`
  String get membershipPlans {
    return Intl.message(
      'Membership Plans',
      name: 'membershipPlans',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message('Buy', name: 'buy', desc: '', args: []);
  }

  /// `Navigate to\nYour Parking\nSpot`
  String get navigateToYourParking {
    return Intl.message(
      'Navigate to\nYour Parking\nSpot',
      name: 'navigateToYourParking',
      desc: '',
      args: [],
    );
  }

  /// `Get Directions`
  String get getDirections {
    return Intl.message(
      'Get Directions',
      name: 'getDirections',
      desc: '',
      args: [],
    );
  }

  /// `Smart Parking`
  String get smartParking {
    return Intl.message(
      'Smart Parking',
      name: 'smartParking',
      desc: '',
      args: [],
    );
  }

  /// `for All Vehicle Types`
  String get forAllVehicleTypes {
    return Intl.message(
      'for All Vehicle Types',
      name: 'forAllVehicleTypes',
      desc: '',
      args: [],
    );
  }

  /// `300+ secured slots for caravans,\nboats, jet skis & more.`
  String get securedSlots {
    return Intl.message(
      '300+ secured slots for caravans,\nboats, jet skis & more.',
      name: 'securedSlots',
      desc: '',
      args: [],
    );
  }

  /// `Book Now!`
  String get bookNow {
    return Intl.message('Book Now!', name: 'bookNow', desc: '', args: []);
  }

  /// `Opportunity!`
  String get opportunity {
    return Intl.message(
      'Opportunity!',
      name: 'opportunity',
      desc: '',
      args: [],
    );
  }

  /// `Check Rewards`
  String get checkRewards {
    return Intl.message(
      'Check Rewards',
      name: 'checkRewards',
      desc: '',
      args: [],
    );
  }

  /// `My Vehicles`
  String get myVehicles {
    return Intl.message('My Vehicles', name: 'myVehicles', desc: '', args: []);
  }

  /// `Recent Activity`
  String get recentActivity {
    return Intl.message(
      'Recent Activity',
      name: 'recentActivity',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Register New Vehicle`
  String get registerNewVehicle {
    return Intl.message(
      'Register New Vehicle',
      name: 'registerNewVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Valid until: {date}`
  String validUntil(String date) {
    return Intl.message(
      'Valid until: $date',
      name: 'validUntil',
      desc: '',
      args: [date],
    );
  }

  /// `Parked at Spot {spot}`
  String parkedAtSpot(String spot) {
    return Intl.message(
      'Parked at Spot $spot',
      name: 'parkedAtSpot',
      desc: '',
      args: [spot],
    );
  }

  /// `Away from Parking`
  String get awayFromParking {
    return Intl.message(
      'Away from Parking',
      name: 'awayFromParking',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Premium`
  String get monthlyPremium {
    return Intl.message(
      'Monthly Premium',
      name: 'monthlyPremium',
      desc: '',
      args: [],
    );
  }

  /// `Parking Renewed`
  String get parkingRenewed {
    return Intl.message(
      'Parking Renewed',
      name: 'parkingRenewed',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Check-in`
  String get vehicleCheckIn {
    return Intl.message(
      'Vehicle Check-in',
      name: 'vehicleCheckIn',
      desc: '',
      args: [],
    );
  }

  /// `License: {number}`
  String license(String number) {
    return Intl.message(
      'License: $number',
      name: 'license',
      desc: '',
      args: [number],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Bookings`
  String get bookings {
    return Intl.message('Bookings', name: 'bookings', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Update your personal details`
  String get updatePersonalDetails {
    return Intl.message(
      'Update your personal details',
      name: 'updatePersonalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Manage your password and security`
  String get manageSecurity {
    return Intl.message(
      'Manage your password and security',
      name: 'manageSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Manage your payment options`
  String get managePaymentOptions {
    return Intl.message(
      'Manage your payment options',
      name: 'managePaymentOptions',
      desc: '',
      args: [],
    );
  }

  /// `View your past bookings`
  String get viewPastBookings {
    return Intl.message(
      'View your past bookings',
      name: 'viewPastBookings',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Get Help with your account`
  String get getHelpAccount {
    return Intl.message(
      'Get Help with your account',
      name: 'getHelpAccount',
      desc: '',
      args: [],
    );
  }

  /// `About Al-Nawaras`
  String get aboutAlNawaras {
    return Intl.message(
      'About Al-Nawaras',
      name: 'aboutAlNawaras',
      desc: '',
      args: [],
    );
  }

  /// `Learn more about our services`
  String get learnMoreServices {
    return Intl.message(
      'Learn more about our services',
      name: 'learnMoreServices',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `No Status`
  String get noStatus {
    return Intl.message('No Status', name: 'noStatus', desc: '', args: []);
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Select Vehicle`
  String get selectVehicle {
    return Intl.message(
      'Select Vehicle',
      name: 'selectVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load rewards`
  String get unableToLoadRewards {
    return Intl.message(
      'Unable to load rewards',
      name: 'unableToLoadRewards',
      desc: '',
      args: [],
    );
  }

  /// `Earn Points`
  String get howToEarnPoints {
    return Intl.message(
      'Earn Points',
      name: 'howToEarnPoints',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Points`
  String get redeemYourRewards {
    return Intl.message(
      'Redeem Points',
      name: 'redeemYourRewards',
      desc: '',
      args: [],
    );
  }

  /// `Earn 50 pts per booking`
  String get earnPerBooking {
    return Intl.message(
      'Earn 50 pts per booking',
      name: 'earnPerBooking',
      desc: '',
      args: [],
    );
  }

  /// `Sharing`
  String get sharing {
    return Intl.message('Sharing', name: 'sharing', desc: '', args: []);
  }

  /// `10 pts per share`
  String get pointsPerShare {
    return Intl.message(
      '10 pts per share',
      name: 'pointsPerShare',
      desc: '',
      args: [],
    );
  }

  /// `Free Parking Day`
  String get freeParkingDay {
    return Intl.message(
      'Free Parking Day',
      name: 'freeParkingDay',
      desc: '',
      args: [],
    );
  }

  /// `Wash Service`
  String get washService {
    return Intl.message(
      'Wash Service',
      name: 'washService',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Rewards`
  String get rewards {
    return Intl.message('Rewards', name: 'rewards', desc: '', args: []);
  }

  /// `Total Points`
  String get totalPoints {
    return Intl.message(
      'Total Points',
      name: 'totalPoints',
      desc: '',
      args: [],
    );
  }

  /// `{count} Points`
  String pointsCount(String count) {
    return Intl.message(
      '$count Points',
      name: 'pointsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Redeem`
  String get redeem {
    return Intl.message('Redeem', name: 'redeem', desc: '', args: []);
  }

  /// `Member Since {date}`
  String memberSince(String date) {
    return Intl.message(
      'Member Since $date',
      name: 'memberSince',
      desc: '',
      args: [date],
    );
  }

  /// `Parking Type`
  String get parkingType {
    return Intl.message(
      'Parking Type',
      name: 'parkingType',
      desc: '',
      args: [],
    );
  }

  /// `Unshaded`
  String get unshaded {
    return Intl.message('Unshaded', name: 'unshaded', desc: '', args: []);
  }

  /// `Shaded`
  String get shaded {
    return Intl.message('Shaded', name: 'shaded', desc: '', args: []);
  }

  /// `Air Conditioned`
  String get airConditioned {
    return Intl.message(
      'Air Conditioned',
      name: 'airConditioned',
      desc: '',
      args: [],
    );
  }

  /// `Membership Package`
  String get membershipPackage {
    return Intl.message(
      'Membership Package',
      name: 'membershipPackage',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get dateTime {
    return Intl.message('Date & Time', name: 'dateTime', desc: '', args: []);
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `Start Time`
  String get startTime {
    return Intl.message('Start Time', name: 'startTime', desc: '', args: []);
  }

  /// `Add-on Services (Optional)`
  String get addonServicesOptional {
    return Intl.message(
      'Add-on Services (Optional)',
      name: 'addonServicesOptional',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Choose the membership plan that best suits your needs`
  String get choosePlanNeeds {
    return Intl.message(
      'Choose the membership plan that best suits your needs',
      name: 'choosePlanNeeds',
      desc: '',
      args: [],
    );
  }

  /// `No membership plans found`
  String get noPlansFound {
    return Intl.message(
      'No membership plans found',
      name: 'noPlansFound',
      desc: '',
      args: [],
    );
  }

  /// `per`
  String get per {
    return Intl.message('per', name: 'per', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Additional Services`
  String get additionalServices {
    return Intl.message(
      'Additional Services',
      name: 'additionalServices',
      desc: '',
      args: [],
    );
  }

  /// `Select from our range of additional services`
  String get selectRangeServices {
    return Intl.message(
      'Select from our range of additional services',
      name: 'selectRangeServices',
      desc: '',
      args: [],
    );
  }

  /// `No services found`
  String get noServicesFound {
    return Intl.message(
      'No services found',
      name: 'noServicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now!`
  String get buyNow {
    return Intl.message('Buy Now!', name: 'buyNow', desc: '', args: []);
  }

  /// `Earn Points`
  String get earnPoints {
    return Intl.message('Earn Points', name: 'earnPoints', desc: '', args: []);
  }

  /// `Redeem Points`
  String get redeemPoints {
    return Intl.message(
      'Redeem Points',
      name: 'redeemPoints',
      desc: '',
      args: [],
    );
  }

  /// `No rules found`
  String get noRulesFound {
    return Intl.message(
      'No rules found',
      name: 'noRulesFound',
      desc: '',
      args: [],
    );
  }

  /// `No redeemable rewards available`
  String get noRedeemableRewards {
    return Intl.message(
      'No redeemable rewards available',
      name: 'noRedeemableRewards',
      desc: '',
      args: [],
    );
  }

  /// `Share & Earn`
  String get shareEarn {
    return Intl.message('Share & Earn', name: 'shareEarn', desc: '', args: []);
  }

  /// `Invite friends and earn more points!`
  String get inviteFriendsPoints {
    return Intl.message(
      'Invite friends and earn more points!',
      name: 'inviteFriendsPoints',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `View Terms & Conditions`
  String get viewTerms {
    return Intl.message(
      'View Terms & Conditions',
      name: 'viewTerms',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
