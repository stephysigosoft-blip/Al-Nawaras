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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Add delivery notes (optional)`
  String get addDeliveryNotesOptional {
    return Intl.message(
      'Add delivery notes (optional)',
      name: 'addDeliveryNotesOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add Item`
  String get addItem {
    return Intl.message(
      'Add Item',
      name: 'addItem',
      desc: '',
      args: [],
    );
  }

  /// `Add More Items`
  String get addMoreItems {
    return Intl.message(
      'Add More Items',
      name: 'addMoreItems',
      desc: '',
      args: [],
    );
  }

  /// `Address not available`
  String get addressNotAvailable {
    return Intl.message(
      'Address not available',
      name: 'addressNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `All Items from This Restaurant`
  String get allItemsFromThisRestaurant {
    return Intl.message(
      'All Items from This Restaurant',
      name: 'allItemsFromThisRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `All Items from this Store`
  String get allItemsFromThisStore {
    return Intl.message(
      'All Items from this Store',
      name: 'allItemsFromThisStore',
      desc: '',
      args: [],
    );
  }

  /// `All Restaurants`
  String get allRestaurants {
    return Intl.message(
      'All Restaurants',
      name: 'allRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `All Stores`
  String get allStores {
    return Intl.message(
      'All Stores',
      name: 'allStores',
      desc: '',
      args: [],
    );
  }

  /// `Already one coupon is applied on this order, if you want to aaply this please remove already applied coupon`
  String get alreadyOneCouponIsAppliedOnThisOrderIfYou {
    return Intl.message(
      'Already one coupon is applied on this order, if you want to aaply this please remove already applied coupon',
      name: 'alreadyOneCouponIsAppliedOnThisOrderIfYou',
      desc: '',
      args: [],
    );
  }

  /// `A new update is available for this app. Please download the latest version to continue using the app.`
  String get aNewUpdateIsAvailableForThisAppPleaseDownload {
    return Intl.message(
      'A new update is available for this app. Please download the latest version to continue using the app.',
      name: 'aNewUpdateIsAvailableForThisAppPleaseDownload',
      desc: '',
      args: [],
    );
  }

  /// `Applied`
  String get applied {
    return Intl.message(
      'Applied',
      name: 'applied',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Apply Coupon`
  String get applyCoupon {
    return Intl.message(
      'Apply Coupon',
      name: 'applyCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this order?`
  String get areYouSureYouWantToCancelThisOrder {
    return Intl.message(
      'Are you sure you want to cancel this order?',
      name: 'areYouSureYouWantToCancelThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are You Sure You Want to Clear This Chat?`
  String get areYouSureYouWantToClearThisChat {
    return Intl.message(
      'Are You Sure You Want to Clear This Chat?',
      name: 'areYouSureYouWantToClearThisChat',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete item from your cart?`
  String get areYouSureYouWantToDeleteItemFromYour {
    return Intl.message(
      'Are you sure you want to delete item from your cart?',
      name: 'areYouSureYouWantToDeleteItemFromYour',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get areYouSureYouWantToDeleteYourAccount {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'areYouSureYouWantToDeleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to place this order?`
  String get areYouSureYouWantToPlaceThisOrder {
    return Intl.message(
      'Are you sure you want to place this order?',
      name: 'areYouSureYouWantToPlaceThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Available at`
  String get availableAt {
    return Intl.message(
      'Available at',
      name: 'availableAt',
      desc: '',
      args: [],
    );
  }

  /// `Available Points`
  String get availablePoints {
    return Intl.message(
      'Available Points',
      name: 'availablePoints',
      desc: '',
      args: [],
    );
  }

  /// `Basket Items`
  String get basketItems {
    return Intl.message(
      'Basket Items',
      name: 'basketItems',
      desc: '',
      args: [],
    );
  }

  /// `Basket Order Details`
  String get basketOrderDetails {
    return Intl.message(
      'Basket Order Details',
      name: 'basketOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Basket Orders`
  String get basketOrders {
    return Intl.message(
      'Basket Orders',
      name: 'basketOrders',
      desc: '',
      args: [],
    );
  }

  /// `Basket Orders`
  String get basketOrderss {
    return Intl.message(
      'Basket Orders',
      name: 'basketOrderss',
      desc: '',
      args: [],
    );
  }

  /// `Beverages`
  String get beverages {
    return Intl.message(
      'Beverages',
      name: 'beverages',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message(
      'Buy Now',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `Call us`
  String get callUs {
    return Intl.message(
      'Call us',
      name: 'callUs',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission is required to scan barcodes`
  String get cameraPermissionIsRequiredToScanBarcodes {
    return Intl.message(
      'Camera permission is required to scan barcodes',
      name: 'cameraPermissionIsRequiredToScanBarcodes',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash on Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Chat now`
  String get chatNow {
    return Intl.message(
      'Chat now',
      name: 'chatNow',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image From :`
  String get chooseImageFrom {
    return Intl.message(
      'Choose Image From :',
      name: 'chooseImageFrom',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message(
      'Clear All',
      name: 'clearAll',
      desc: '',
      args: [],
    );
  }

  /// `Confirm & Proceed`
  String get confirmProceed {
    return Intl.message(
      'Confirm & Proceed',
      name: 'confirmProceed',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! You’ve earned`
  String get congratulationsYouveEarned {
    return Intl.message(
      'Congratulations! You’ve earned',
      name: 'congratulationsYouveEarned',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Coupon code copied!`
  String get couponCodeCopied {
    return Intl.message(
      'Coupon code copied!',
      name: 'couponCodeCopied',
      desc: '',
      args: [],
    );
  }

  /// `Cravings calling? Answer with a bite!`
  String get cravingsCallingAnswerWithABite {
    return Intl.message(
      'Cravings calling? Answer with a bite!',
      name: 'cravingsCallingAnswerWithABite',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Crop`
  String get crop {
    return Intl.message(
      'Crop',
      name: 'crop',
      desc: '',
      args: [],
    );
  }

  /// `Crop Image`
  String get cropImage {
    return Intl.message(
      'Crop Image',
      name: 'cropImage',
      desc: '',
      args: [],
    );
  }

  /// `Current Location`
  String get currentLocation {
    return Intl.message(
      'Current Location',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Currently Closed`
  String get currentlyClosed {
    return Intl.message(
      'Currently Closed',
      name: 'currentlyClosed',
      desc: '',
      args: [],
    );
  }

  /// `Currently closed • Opens`
  String get currentlyClosedOpens {
    return Intl.message(
      'Currently closed • Opens',
      name: 'currentlyClosedOpens',
      desc: '',
      args: [],
    );
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

  /// `Currently no restaurants are available in this area. Try again later.`
  String get currentlyNoRestaurantsAreAvailableInThisAreaTryAgain {
    return Intl.message(
      'Currently no restaurants are available in this area. Try again later.',
      name: 'currentlyNoRestaurantsAreAvailableInThisAreaTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Currently no restaurants found`
  String get currentlyNoRestaurantsFound {
    return Intl.message(
      'Currently no restaurants found',
      name: 'currentlyNoRestaurantsFound',
      desc: '',
      args: [],
    );
  }

  /// `Currently no stores found`
  String get currentlyNoStoresFound {
    return Intl.message(
      'Currently no stores found',
      name: 'currentlyNoStoresFound',
      desc: '',
      args: [],
    );
  }

  /// `d ago`
  String get dAgo {
    return Intl.message(
      'd ago',
      name: 'dAgo',
      desc: '',
      args: [],
    );
  }

  /// `Debit`
  String get debit {
    return Intl.message(
      'Debit',
      name: 'debit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Cart`
  String get deleteCart {
    return Intl.message(
      'Delete Cart',
      name: 'deleteCart',
      desc: '',
      args: [],
    );
  }

  /// `Delete Chat`
  String get deleteChat {
    return Intl.message(
      'Delete Chat',
      name: 'deleteChat',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get deliveryFee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Location`
  String get deliveryLocation {
    return Intl.message(
      'Delivery Location',
      name: 'deliveryLocation',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t get the OTP?`
  String get didntGetTheOtp {
    return Intl.message(
      'Didn’t get the OTP?',
      name: 'didntGetTheOtp',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `. Do you want to replace them with items from`
  String get doYouWantToReplaceThemWithDishesFrom {
    return Intl.message(
      '. Do you want to replace them with items from',
      name: 'doYouWantToReplaceThemWithDishesFrom',
      desc: '',
      args: [],
    );
  }

  /// `Driver`
  String get driver {
    return Intl.message(
      'Driver',
      name: 'driver',
      desc: '',
      args: [],
    );
  }

  /// `Driver Details`
  String get driverDetails {
    return Intl.message(
      'Driver Details',
      name: 'driverDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email us`
  String get emailUs {
    return Intl.message(
      'Email us',
      name: 'emailUs',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your quantity here`
  String get enterYourQuantityHere {
    return Intl.message(
      'Enter your quantity here',
      name: 'enterYourQuantityHere',
      desc: '',
      args: [],
    );
  }

  /// `Enter your whatsapp number`
  String get enterYourWhatsappNumber {
    return Intl.message(
      'Enter your whatsapp number',
      name: 'enterYourWhatsappNumber',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Filters & Sorting`
  String get filtersSorting {
    return Intl.message(
      'Filters & Sorting',
      name: 'filtersSorting',
      desc: '',
      args: [],
    );
  }

  /// `Find something from this restaurant`
  String get findSomethingFromThisRestaurant {
    return Intl.message(
      'Find something from this restaurant',
      name: 'findSomethingFromThisRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Got It`
  String get gotIt {
    return Intl.message(
      'Got It',
      name: 'gotIt',
      desc: '',
      args: [],
    );
  }

  /// `Grocery`
  String get grocery {
    return Intl.message(
      'Grocery',
      name: 'grocery',
      desc: '',
      args: [],
    );
  }

  /// `h ago`
  String get hAgo {
    return Intl.message(
      'h ago',
      name: 'hAgo',
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

  /// `Invalid product ID`
  String get invalidProductId {
    return Intl.message(
      'Invalid product ID',
      name: 'invalidProductId',
      desc: '',
      args: [],
    );
  }

  /// `Invalid product information`
  String get invalidProductInformation {
    return Intl.message(
      'Invalid product information',
      name: 'invalidProductInformation',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Item Total`
  String get itemTotal {
    return Intl.message(
      'Item Total',
      name: 'itemTotal',
      desc: '',
      args: [],
    );
  }

  /// `Km`
  String get km {
    return Intl.message(
      'Km',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `Loading location...`
  String get loadingLocation {
    return Intl.message(
      'Loading location...',
      name: 'loadingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login or Sign up`
  String get loginOrSignUp {
    return Intl.message(
      'Login or Sign up',
      name: 'loginOrSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `m ago`
  String get mAgo {
    return Intl.message(
      'm ago',
      name: 'mAgo',
      desc: '',
      args: [],
    );
  }

  /// `Mins`
  String get mins {
    return Intl.message(
      'Mins',
      name: 'mins',
      desc: '',
      args: [],
    );
  }

  /// `Missed Something?`
  String get missedSomething {
    return Intl.message(
      'Missed Something?',
      name: 'missedSomething',
      desc: '',
      args: [],
    );
  }

  /// `More Points`
  String get morePoints {
    return Intl.message(
      'More Points',
      name: 'morePoints',
      desc: '',
      args: [],
    );
  }

  /// `MRU on this order`
  String get mruOnThisOrder {
    return Intl.message(
      'MRU on this order',
      name: 'mruOnThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `MRU with this code`
  String get mruWithThisCode {
    return Intl.message(
      'MRU with this code',
      name: 'mruWithThisCode',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `My Points`
  String get myPoints {
    return Intl.message(
      'My Points',
      name: 'myPoints',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Need`
  String get need {
    return Intl.message(
      'Need',
      name: 'need',
      desc: '',
      args: [],
    );
  }

  /// `Need it fresh? Add it to your cart!`
  String get needItFreshAddItToYourCart {
    return Intl.message(
      'Need it fresh? Add it to your cart!',
      name: 'needItFreshAddItToYourCart',
      desc: '',
      args: [],
    );
  }

  /// `Needs An Update`
  String get needsAnUpdate {
    return Intl.message(
      'Needs An Update',
      name: 'needsAnUpdate',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No Categories Found`
  String get noCategoriesFound {
    return Intl.message(
      'No Categories Found',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `No Conversations`
  String get noConversations {
    return Intl.message(
      'No Conversations',
      name: 'noConversations',
      desc: '',
      args: [],
    );
  }

  /// `No conversations found`
  String get noConversationsFound {
    return Intl.message(
      'No conversations found',
      name: 'noConversationsFound',
      desc: '',
      args: [],
    );
  }

  /// `No Coupons Available`
  String get noCouponsAvailable {
    return Intl.message(
      'No Coupons Available',
      name: 'noCouponsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No coupons available right now.`
  String get noCouponsAvailableRightNow {
    return Intl.message(
      'No coupons available right now.',
      name: 'noCouponsAvailableRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No Groceries Found`
  String get noGroceriesFound {
    return Intl.message(
      'No Groceries Found',
      name: 'noGroceriesFound',
      desc: '',
      args: [],
    );
  }

  /// `No grocery orders yet`
  String get noGroceryOrdersYet {
    return Intl.message(
      'No grocery orders yet',
      name: 'noGroceryOrdersYet',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again.`
  String get noInternetConnectionDescription {
    return Intl.message(
      'Please check your internet connection and try again.',
      name: 'noInternetConnectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `No Items Found`
  String get noItemsFound {
    return Intl.message(
      'No Items Found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `No messages`
  String get noMessages {
    return Intl.message(
      'No messages',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet`
  String get noMessagesYet {
    return Intl.message(
      'No messages yet',
      name: 'noMessagesYet',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `No notifications found`
  String get noNotificationsFound {
    return Intl.message(
      'No notifications found',
      name: 'noNotificationsFound',
      desc: '',
      args: [],
    );
  }

  /// `No options available`
  String get noOptionsAvailable {
    return Intl.message(
      'No options available',
      name: 'noOptionsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No order details found`
  String get noOrderDetailsFound {
    return Intl.message(
      'No order details found',
      name: 'noOrderDetailsFound',
      desc: '',
      args: [],
    );
  }

  /// `No Orders`
  String get noOrders {
    return Intl.message(
      'No Orders',
      name: 'noOrders',
      desc: '',
      args: [],
    );
  }

  /// `No redeemable rewards`
  String get noRedeemableRewards {
    return Intl.message(
      'No redeemable rewards',
      name: 'noRedeemableRewards',
      desc: '',
      args: [],
    );
  }

  /// `No Restaurants Found`
  String get noRestaurantsFound {
    return Intl.message(
      'No Restaurants Found',
      name: 'noRestaurantsFound',
      desc: '',
      args: [],
    );
  }

  /// `No Restaurants Founds`
  String get noRestaurantsFounds {
    return Intl.message(
      'No Restaurants Founds',
      name: 'noRestaurantsFounds',
      desc: '',
      args: [],
    );
  }

  /// `No Stores Found`
  String get noStoresFound {
    return Intl.message(
      'No Stores Found',
      name: 'noStoresFound',
      desc: '',
      args: [],
    );
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

  /// `No tracking details found`
  String get noTrackingDetailsFound {
    return Intl.message(
      'No tracking details found',
      name: 'noTrackingDetailsFound',
      desc: '',
      args: [],
    );
  }

  /// `No transaction history available`
  String get noTransactionHistoryAvailable {
    return Intl.message(
      'No transaction history available',
      name: 'noTransactionHistoryAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get off {
    return Intl.message(
      'OFF',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Online Payment`
  String get onlinePayment {
    return Intl.message(
      'Online Payment',
      name: 'onlinePayment',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Ordered`
  String get ordered {
    return Intl.message(
      'Ordered',
      name: 'ordered',
      desc: '',
      args: [],
    );
  }

  /// `Ordered Items`
  String get orderedItems {
    return Intl.message(
      'Ordered Items',
      name: 'orderedItems',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully!`
  String get orderPlacedSuccessfully {
    return Intl.message(
      'Order placed successfully!',
      name: 'orderPlacedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otpVerification {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `Out of Stock`
  String get outOfStock {
    return Intl.message(
      'Out of Stock',
      name: 'outOfStock',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Payment Details`
  String get paymentDetails {
    return Intl.message(
      'Payment Details',
      name: 'paymentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Payment Type`
  String get paymentType {
    return Intl.message(
      'Payment Type',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pick what you want and fill your basket!`
  String get pickWhatYouWantAndFillYourBasket {
    return Intl.message(
      'Pick what you want and fill your basket!',
      name: 'pickWhatYouWantAndFillYourBasket',
      desc: '',
      args: [],
    );
  }

  /// `Pick your favourites and start your feast!`
  String get pickYourFavouritesAndStartYourFeast {
    return Intl.message(
      'Pick your favourites and start your feast!',
      name: 'pickYourFavouritesAndStartYourFeast',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please add your items to cart`
  String get pleaseAddYourItemsToCart {
    return Intl.message(
      'Please add your items to cart',
      name: 'pleaseAddYourItemsToCart',
      desc: '',
      args: [],
    );
  }

  /// `Please choose location`
  String get pleaseChooseLocation {
    return Intl.message(
      'Please choose location',
      name: 'pleaseChooseLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter coupon code`
  String get pleaseEnterCouponCode {
    return Intl.message(
      'Please enter coupon code',
      name: 'pleaseEnterCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter name of length atleast 3`
  String get pleaseEnterNameOfLengthAtleast3 {
    return Intl.message(
      'Please enter name of length atleast 3',
      name: 'pleaseEnterNameOfLengthAtleast3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter otp`
  String get pleaseEnterOtp {
    return Intl.message(
      'Please enter otp',
      name: 'pleaseEnterOtp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code sent to`
  String get pleaseEnterTheVerificationCodeSentTo {
    return Intl.message(
      'Please enter the verification code sent to',
      name: 'pleaseEnterTheVerificationCodeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid otp`
  String get pleaseEnterValidOtp {
    return Intl.message(
      'Please enter valid otp',
      name: 'pleaseEnterValidOtp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number`
  String get pleaseEnterYourMobileNumber {
    return Intl.message(
      'Please enter your mobile number',
      name: 'pleaseEnterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your quantity`
  String get pleaseEnterYourQuantity {
    return Intl.message(
      'Please enter your quantity',
      name: 'pleaseEnterYourQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Please login`
  String get pleaseLogin {
    return Intl.message(
      'Please login',
      name: 'pleaseLogin',
      desc: '',
      args: [],
    );
  }

  /// `Please login to use this feature`
  String get pleaseLoginToUseThisFeature {
    return Intl.message(
      'Please login to use this feature',
      name: 'pleaseLoginToUseThisFeature',
      desc: '',
      args: [],
    );
  }

  /// `points`
  String get points {
    return Intl.message(
      'points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Position the barcode within the frame`
  String get positionTheBarcodeWithinTheFrame {
    return Intl.message(
      'Position the barcode within the frame',
      name: 'positionTheBarcodeWithinTheFrame',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message(
      'Proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Product out of stock`
  String get productOutOfStock {
    return Intl.message(
      'Product out of stock',
      name: 'productOutOfStock',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Rate Order`
  String get rateOrder {
    return Intl.message(
      'Rate Order',
      name: 'rateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Rate Ordered Items`
  String get rateOrderedItems {
    return Intl.message(
      'Rate Ordered Items',
      name: 'rateOrderedItems',
      desc: '',
      args: [],
    );
  }

  /// `Rate Restaurant Review`
  String get rateRestaurantReview {
    return Intl.message(
      'Rate Restaurant Review',
      name: 'rateRestaurantReview',
      desc: '',
      args: [],
    );
  }

  /// `Rate Store Review`
  String get rateStoreReview {
    return Intl.message(
      'Rate Store Review',
      name: 'rateStoreReview',
      desc: '',
      args: [],
    );
  }

  /// `Rate Your Delivery Experience`
  String get rateYourDeliveryExperience {
    return Intl.message(
      'Rate Your Delivery Experience',
      name: 'rateYourDeliveryExperience',
      desc: '',
      args: [],
    );
  }

  /// `Rate Your Order`
  String get rateYourOrder {
    return Intl.message(
      'Rate Your Order',
      name: 'rateYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Redeemable Rewards`
  String get redeemableRewards {
    return Intl.message(
      'Redeemable Rewards',
      name: 'redeemableRewards',
      desc: '',
      args: [],
    );
  }

  /// `Redeemed`
  String get redeemed {
    return Intl.message(
      'Redeemed',
      name: 'redeemed',
      desc: '',
      args: [],
    );
  }

  /// `Redeemed Amount`
  String get redeemedAmount {
    return Intl.message(
      'Redeemed Amount',
      name: 'redeemedAmount',
      desc: '',
      args: [],
    );
  }

  /// `Redeemed Points`
  String get redeemedPoints {
    return Intl.message(
      'Redeemed Points',
      name: 'redeemedPoints',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Now`
  String get redeemNow {
    return Intl.message(
      'Redeem Now',
      name: 'redeemNow',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Replace`
  String get replace {
    return Intl.message(
      'Replace',
      name: 'replace',
      desc: '',
      args: [],
    );
  }

  /// `Replace cart item?`
  String get replaceCartItem {
    return Intl.message(
      'Replace cart item?',
      name: 'replaceCartItem',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in 30 sec`
  String get resendCodeIn30Sec {
    return Intl.message(
      'Resend code in 30 sec',
      name: 'resendCodeIn30Sec',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOtp {
    return Intl.message(
      'Resend OTP',
      name: 'resendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant`
  String get restaurant {
    return Intl.message(
      'Restaurant',
      name: 'restaurant',
      desc: '',
      args: [],
    );
  }

  /// `reviews`
  String get reviews {
    return Intl.message(
      'reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `SAIMPEX`
  String get saimpex {
    return Intl.message(
      'SAIMPEX',
      name: 'saimpex',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Scan Barcode`
  String get scanBarcode {
    return Intl.message(
      'Scan Barcode',
      name: 'scanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search Categories`
  String get searchCategories {
    return Intl.message(
      'Search Categories',
      name: 'searchCategories',
      desc: '',
      args: [],
    );
  }

  /// `Search for area, street name.....`
  String get searchForAreaStreetName {
    return Intl.message(
      'Search for area, street name.....',
      name: 'searchForAreaStreetName',
      desc: '',
      args: [],
    );
  }

  /// `Search for items`
  String get searchForItems {
    return Intl.message(
      'Search for items',
      name: 'searchForItems',
      desc: '',
      args: [],
    );
  }

  /// `Select Delivery Location`
  String get selectDeliveryLocation {
    return Intl.message(
      'Select Delivery Location',
      name: 'selectDeliveryLocation',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Location`
  String get selectYourLocation {
    return Intl.message(
      'Select Your Location',
      name: 'selectYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Server Down`
  String get serverDown {
    return Intl.message(
      'Server Down',
      name: 'serverDown',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we're down for maintenance  We'll be back up shortly.`
  String get sorryWereDownForMaintenanceWellBeBackUpShortly {
    return Intl.message(
      'Sorry, we\'re down for maintenance  We\'ll be back up shortly.',
      name: 'sorryWereDownForMaintenanceWellBeBackUpShortly',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Sort & Filter`
  String get sortFilter {
    return Intl.message(
      'Sort & Filter',
      name: 'sortFilter',
      desc: '',
      args: [],
    );
  }

  /// `Start typing to search`
  String get startTypingToSearch {
    return Intl.message(
      'Start typing to search',
      name: 'startTypingToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Submit Rating`
  String get submitRating {
    return Intl.message(
      'Submit Rating',
      name: 'submitRating',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `The restaurant preparing your food`
  String get theRestaurantPreparingYourFood {
    return Intl.message(
      'The restaurant preparing your food',
      name: 'theRestaurantPreparingYourFood',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `To Pay`
  String get toPay {
    return Intl.message(
      'To Pay',
      name: 'toPay',
      desc: '',
      args: [],
    );
  }

  /// `Top Selling Dishes`
  String get topSellingDishes {
    return Intl.message(
      'Top Selling Dishes',
      name: 'topSellingDishes',
      desc: '',
      args: [],
    );
  }

  /// `Total Bill`
  String get totalBill {
    return Intl.message(
      'Total Bill',
      name: 'totalBill',
      desc: '',
      args: [],
    );
  }

  /// `Track Order`
  String get trackOrder {
    return Intl.message(
      'Track Order',
      name: 'trackOrder',
      desc: '',
      args: [],
    );
  }

  /// `Track Your Order`
  String get trackYourOrder {
    return Intl.message(
      'Track Your Order',
      name: 'trackYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transactionHistory {
    return Intl.message(
      'Transaction History',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Try searching with different keywords`
  String get trySearchingWithDifferentKeywords {
    return Intl.message(
      'Try searching with different keywords',
      name: 'trySearchingWithDifferentKeywords',
      desc: '',
      args: [],
    );
  }

  /// `Type a message…`
  String get typeAMessage {
    return Intl.message(
      'Type a message…',
      name: 'typeAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Type your review here`
  String get typeYourReviewHere {
    return Intl.message(
      'Type your review here',
      name: 'typeYourReviewHere',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Driver`
  String get unknownDriver {
    return Intl.message(
      'Unknown Driver',
      name: 'unknownDriver',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Vendor`
  String get unknownVendor {
    return Intl.message(
      'Unknown Vendor',
      name: 'unknownVendor',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Upto`
  String get upto {
    return Intl.message(
      'Upto',
      name: 'upto',
      desc: '',
      args: [],
    );
  }

  /// `Vendor`
  String get vendor {
    return Intl.message(
      'Vendor',
      name: 'vendor',
      desc: '',
      args: [],
    );
  }

  /// `View all coupons`
  String get viewAllCoupons {
    return Intl.message(
      'View all coupons',
      name: 'viewAllCoupons',
      desc: '',
      args: [],
    );
  }

  /// `View Orders`
  String get viewOrders {
    return Intl.message(
      'View Orders',
      name: 'viewOrders',
      desc: '',
      args: [],
    );
  }

  /// `We'll be back soon`
  String get wellBeBackSoon {
    return Intl.message(
      'We\'ll be back soon',
      name: 'wellBeBackSoon',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent a verification code to your WhatsApp`
  String get weveSentAVerificationCodeToYourWhatsapp {
    return Intl.message(
      'We’ve sent a verification code to your WhatsApp',
      name: 'weveSentAVerificationCodeToYourWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `What do you need today?`
  String get whatDoYouNeedToday {
    return Intl.message(
      'What do you need today?',
      name: 'whatDoYouNeedToday',
      desc: '',
      args: [],
    );
  }

  /// `What’s your name?`
  String get whatsYourName {
    return Intl.message(
      'What’s your name?',
      name: 'whatsYourName',
      desc: '',
      args: [],
    );
  }

  /// `% with this code`
  String get withThisCode {
    return Intl.message(
      '% with this code',
      name: 'withThisCode',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `You are logged out successfully.`
  String get youAreLoggedOutSuccessfully {
    return Intl.message(
      'You are logged out successfully.',
      name: 'youAreLoggedOutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You cannot delete this item from here, to checkout minimum one product is required`
  String get youCannotDeleteThisItemFromHereToCheckoutMinimum {
    return Intl.message(
      'You cannot delete this item from here, to checkout minimum one product is required',
      name: 'youCannotDeleteThisItemFromHereToCheckoutMinimum',
      desc: '',
      args: [],
    );
  }

  /// `You might also like`
  String get youMightAlsoLike {
    return Intl.message(
      'You might also like',
      name: 'youMightAlsoLike',
      desc: '',
      args: [],
    );
  }

  /// `Your cart has items from`
  String get yourCartHasDishesFrom {
    return Intl.message(
      'Your cart has items from',
      name: 'yourCartHasDishesFrom',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart is Empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your Cart is Empty',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been delivered`
  String get yourOrderHasBeenDelivered {
    return Intl.message(
      'Your order has been delivered',
      name: 'yourOrderHasBeenDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been picked up for delivery`
  String get yourOrderHasBeenPickedUpForDelivery {
    return Intl.message(
      'Your order has been picked up for delivery',
      name: 'yourOrderHasBeenPickedUpForDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been received`
  String get yourOrderHasBeenReceived {
    return Intl.message(
      'Your order has been received',
      name: 'yourOrderHasBeenReceived',
      desc: '',
      args: [],
    );
  }

  /// `Your Orders`
  String get yourOrders {
    return Intl.message(
      'Your Orders',
      name: 'yourOrders',
      desc: '',
      args: [],
    );
  }

  /// `Your trusted food & grocery delivery partner`
  String get yourTrustedFoodGroceryDeliveryPartner {
    return Intl.message(
      'Your trusted food & grocery delivery partner',
      name: 'yourTrustedFoodGroceryDeliveryPartner',
      desc: '',
      args: [],
    );
  }

  /// `You saved`
  String get youSaved {
    return Intl.message(
      'You saved',
      name: 'youSaved',
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
      Locale.fromSubtags(languageCode: 'fr'),
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
