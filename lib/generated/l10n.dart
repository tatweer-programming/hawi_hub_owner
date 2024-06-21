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

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Your places`
  String get yourPlaces {
    return Intl.message(
      'Your places',
      name: 'yourPlaces',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Add booking`
  String get addBooking {
    return Intl.message(
      'Add booking',
      name: 'addBooking',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Minimum booking`
  String get minimumBooking {
    return Intl.message(
      'Minimum booking',
      name: 'minimumBooking',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `No details`
  String get noDetails {
    return Intl.message(
      'No details',
      name: 'noDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sport`
  String get sport {
    return Intl.message(
      'Sport',
      name: 'sport',
      desc: '',
      args: [],
    );
  }

  /// `Places`
  String get places {
    return Intl.message(
      'Places',
      name: 'places',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `View details`
  String get viewDetails {
    return Intl.message(
      'View details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `No places found`
  String get noPlaces {
    return Intl.message(
      'No places found',
      name: 'noPlaces',
      desc: '',
      args: [],
    );
  }

  /// `No requests found`
  String get noRequests {
    return Intl.message(
      'No requests found',
      name: 'noRequests',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `per hour`
  String get perHour {
    return Intl.message(
      'per hour',
      name: 'perHour',
      desc: '',
      args: [],
    );
  }

  /// `Total games`
  String get totalGames {
    return Intl.message(
      'Total games',
      name: 'totalGames',
      desc: '',
      args: [],
    );
  }

  /// `No ratings yet`
  String get noRatings {
    return Intl.message(
      'No ratings yet',
      name: 'noRatings',
      desc: '',
      args: [],
    );
  }

  /// `Show in map`
  String get showInMap {
    return Intl.message(
      'Show in map',
      name: 'showInMap',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this place?`
  String get deletePlaceConfirmation {
    return Intl.message(
      'Are you sure you want to delete this place?',
      name: 'deletePlaceConfirmation',
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

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit place`
  String get editPlace {
    return Intl.message(
      'Edit place',
      name: 'editPlace',
      desc: '',
      args: [],
    );
  }

  /// `Delete place`
  String get deletePlace {
    return Intl.message(
      'Delete place',
      name: 'deletePlace',
      desc: '',
      args: [],
    );
  }

  /// `Add place`
  String get addPlace {
    return Intl.message(
      'Add place',
      name: 'addPlace',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get requiredField {
    return Intl.message(
      'Required field',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Place name`
  String get placeName {
    return Intl.message(
      'Place name',
      name: 'placeName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Minimum hours for booking`
  String get minimumHours {
    return Intl.message(
      'Minimum hours for booking',
      name: 'minimumHours',
      desc: '',
      args: [],
    );
  }

  /// `Request added successfully`
  String get placeAdded {
    return Intl.message(
      'Request added successfully',
      name: 'placeAdded',
      desc: '',
      args: [],
    );
  }

  /// `Working hours`
  String get workingHours {
    return Intl.message(
      'Working hours',
      name: 'workingHours',
      desc: '',
      args: [],
    );
  }

  /// `Add working hours`
  String get addWorkingHours {
    return Intl.message(
      'Add working hours',
      name: 'addWorkingHours',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Add images`
  String get addImages {
    return Intl.message(
      'Add images',
      name: 'addImages',
      desc: '',
      args: [],
    );
  }

  /// `Ownership file`
  String get ownershipFile {
    return Intl.message(
      'Ownership file',
      name: 'ownershipFile',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
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

  /// `Weekend`
  String get weekend {
    return Intl.message(
      'Weekend',
      name: 'weekend',
      desc: '',
      args: [],
    );
  }

  /// `Ownership file is required`
  String get ownerShipIsRequired {
    return Intl.message(
      'Ownership file is required',
      name: 'ownerShipIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Image is required`
  String get imageIsRequired {
    return Intl.message(
      'Image is required',
      name: 'imageIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `City is required`
  String get cityIsRequired {
    return Intl.message(
      'City is required',
      name: 'cityIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Sport is required`
  String get sportIsRequired {
    return Intl.message(
      'Sport is required',
      name: 'sportIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Always open`
  String get alwaysOpen {
    return Intl.message(
      'Always open',
      name: 'alwaysOpen',
      desc: '',
      args: [],
    );
  }

  /// `Place edited successfully`
  String get placeEditedSuccessfully {
    return Intl.message(
      'Place edited successfully',
      name: 'placeEditedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `View profile`
  String get viewProfile {
    return Intl.message(
      'View profile',
      name: 'viewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Booking time`
  String get bookingTime {
    return Intl.message(
      'Booking time',
      name: 'bookingTime',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get userName {
    return Intl.message(
      'User name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get startTime {
    return Intl.message(
      'Start time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get endTime {
    return Intl.message(
      'End time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required`
  String get allFieldsIsRequired {
    return Intl.message(
      'All fields are required',
      name: 'allFieldsIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `End time must be after start time`
  String get endTimeMustBeAfterStartTime {
    return Intl.message(
      'End time must be after start time',
      name: 'endTimeMustBeAfterStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Booking outside working hours`
  String get bookingNotAllowed {
    return Intl.message(
      'Booking outside working hours',
      name: 'bookingNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Place deleted successfully`
  String get placeDeleted {
    return Intl.message(
      'Place deleted successfully',
      name: 'placeDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Value`
  String get invalidValue {
    return Intl.message(
      'Invalid Value',
      name: 'invalidValue',
      desc: '',
      args: [],
    );
  }

  /// `Booking Created Successfully`
  String get bookingCreated {
    return Intl.message(
      'Booking Created Successfully',
      name: 'bookingCreated',
      desc: '',
      args: [],
    );
  }

  /// `No minimum booking`
  String get noMinimumBooking {
    return Intl.message(
      'No minimum booking',
      name: 'noMinimumBooking',
      desc: '',
      args: [],
    );
  }

  /// `Under review`
  String get underReview {
    return Intl.message(
      'Under review',
      name: 'underReview',
      desc: '',
      args: [],
    );
  }

  /// `You should activate your account first`
  String get shouldActivate {
    return Intl.message(
      'You should activate your account first',
      name: 'shouldActivate',
      desc: '',
      args: [],
    );
  }

  /// `You should login first`
  String get loginFirst {
    return Intl.message(
      'You should login first',
      name: 'loginFirst',
      desc: '',
      args: [],
    );
  }

  /// `The ID card is being verified now`
  String get identificationPending {
    return Intl.message(
      'The ID card is being verified now',
      name: 'identificationPending',
      desc: '',
      args: [],
    );
  }

  /// `You must verify your account first `
  String get mustVerifyAccount {
    return Intl.message(
      'You must verify your account first ',
      name: 'mustVerifyAccount',
      desc: '',
      args: [],
    );
  }

  /// `File Uploaded`
  String get fileUploaded {
    return Intl.message(
      'File Uploaded',
      name: 'fileUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get myWallet {
    return Intl.message(
      'My Wallet',
      name: 'myWallet',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get signUp {
    return Intl.message(
      'SIGN UP',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account ?`
  String get noAccount {
    return Intl.message(
      'Don’t have an account ?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Keep me logged in`
  String get keepMeLoggedIn {
    return Intl.message(
      'Keep me logged in',
      name: 'keepMeLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login {
    return Intl.message(
      'LOGIN',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get enterPassword {
    return Intl.message(
      'Please enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get enterEmail {
    return Intl.message(
      'Please enter email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter username`
  String get enterUsername {
    return Intl.message(
      'Please enter username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password ?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password ?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// ` Username`
  String get username {
    return Intl.message(
      ' Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// ` Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      ' Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// ` Email`
  String get email {
    return Intl.message(
      ' Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
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

  /// `Please enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Please enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Please enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get start {
    return Intl.message(
      'Get Started',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Email is not exists`
  String get emailNotExists {
    return Intl.message(
      'Email is not exists',
      name: 'emailNotExists',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Received Code`
  String get receivedCode {
    return Intl.message(
      'Received Code',
      name: 'receivedCode',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `You can resend code after `
  String get sendCodeAfter {
    return Intl.message(
      'You can resend code after ',
      name: 'sendCodeAfter',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully`
  String get passwordResetSuccessfully {
    return Intl.message(
      'Password reset successfully',
      name: 'passwordResetSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Account Created Successfully`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Account Created Successfully',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Email is not exists.`
  String get userNotFound {
    return Intl.message(
      'Email is not exists.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Email is already exists.`
  String get emailAlreadyExist {
    return Intl.message(
      'Email is already exists.',
      name: 'emailAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Username is already exists.`
  String get usernameAlreadyExist {
    return Intl.message(
      'Username is already exists.',
      name: 'usernameAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get shortPassword {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password.`
  String get invalidEmailOrPassword {
    return Intl.message(
      'Invalid email or password.',
      name: 'invalidEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Account LogeIn Successfully`
  String get loginSuccessfully {
    return Intl.message(
      'Account LogeIn Successfully',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password !`
  String get wrongPassword {
    return Intl.message(
      'Wrong password !',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password has been changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password has been changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Reset code sent successfully to `
  String get resetCodeSentSuccessfully {
    return Intl.message(
      'Reset code sent successfully to ',
      name: 'resetCodeSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Proof of identity has been added successfully`
  String get proofOfIdentityAddedSuccessfully {
    return Intl.message(
      'Proof of identity has been added successfully',
      name: 'proofOfIdentityAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change `
  String get change {
    return Intl.message(
      'Change ',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `No comment`
  String get noComment {
    return Intl.message(
      'No comment',
      name: 'noComment',
      desc: '',
      args: [],
    );
  }

  /// `CHECK YOUR NETWORK`
  String get checkYourNetwork {
    return Intl.message(
      'CHECK YOUR NETWORK',
      name: 'checkYourNetwork',
      desc: '',
      args: [],
    );
  }

  /// `People Rate`
  String get peopleRate {
    return Intl.message(
      'People Rate',
      name: 'peopleRate',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Please enter code`
  String get enterCode {
    return Intl.message(
      'Please enter code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the Terms of Service and Privacy Policy.`
  String get agreeTerms {
    return Intl.message(
      'I agree to the Terms of Service and Privacy Policy.',
      name: 'agreeTerms',
      desc: '',
      args: [],
    );
  }

  /// `The file was rejected. Check the required information carefully and try again`
  String get rejectIdCard {
    return Intl.message(
      'The file was rejected. Check the required information carefully and try again',
      name: 'rejectIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Feedbacks`
  String get feedbacks {
    return Intl.message(
      'Feedbacks',
      name: 'feedbacks',
      desc: '',
      args: [],
    );
  }

  /// `No Feedbacks yet`
  String get noFeedbacks {
    return Intl.message(
      'No Feedbacks yet',
      name: 'noFeedbacks',
      desc: '',
      args: [],
    );
  }

  /// `No Alerts`
  String get noAlerts {
    return Intl.message(
      'No Alerts',
      name: 'noAlerts',
      desc: '',
      args: [],
    );
  }

  /// `View Feedbacks`
  String get viewFeedbacks {
    return Intl.message(
      'View Feedbacks',
      name: 'viewFeedbacks',
      desc: '',
      args: [],
    );
  }

  /// `Uploading Attachments...`
  String get uploadingAttachment {
    return Intl.message(
      'Uploading Attachments...',
      name: 'uploadingAttachment',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Conditions`
  String get preferenceAndPrivacy {
    return Intl.message(
      'Terms And Conditions',
      name: 'preferenceAndPrivacy',
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

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Common Questions`
  String get commonQuestions {
    return Intl.message(
      'Common Questions',
      name: 'commonQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Club Rate`
  String get clubRate {
    return Intl.message(
      'Club Rate',
      name: 'clubRate',
      desc: '',
      args: [],
    );
  }

  /// `Player Rate`
  String get playerRate {
    return Intl.message(
      'Player Rate',
      name: 'playerRate',
      desc: '',
      args: [],
    );
  }

  /// `Add Comment`
  String get addComment {
    return Intl.message(
      'Add Comment',
      name: 'addComment',
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

  /// `hey! to share our app visit `
  String get shareApp {
    return Intl.message(
      'hey! to share our app visit ',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `What is the Howie Hub application?\n\nIt is an application that connects stadium owners with tenants, facilitating the process of booking stadiums individually or collectively.\n\nWho can use the Howie Hub application?\n\nAnyone can download and use the app, but it specifically targets young people in Saudi Arabia.\n\nWhat services does the application provide?\n\nBook pitches individually:\nSelect the stadium you want.\nChoose the appropriate date and time.\nComplete the payment process.\nCreate group bookings and share them with friends:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share with your friends.\nCreate group bookings open to all app users:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share it with everyone.\nHow is payment made in the Howie Hub application?\n\nPayment is made by credit card or online payment card.\n\nWhat is the percentage of the company that owns the application of the reservation value?\n\nThe percentage of the reservation value of the company that owns the application varies depending on the type of reservation.\n\nHow can I add a playground to the app?\n\nIf you are a stadium owner, you can contact the company that owns the application through https://www.infohub.com/ to learn more about how to add your stadium to the application.\n\nHow can I contact the company that owns the application?\n\nYou can contact the company that owns the application through https://www.infohub.com/\n\nAre there any restrictions or specific conditions for using the application?\n\nThere are no restrictions or conditions for using the app, but you must respect all users on the app and refrain from any abusive or illegal behavior.\n\nAre there any behaviors prohibited on the application?\n\nYes, there are some behaviors that are prohibited on the application, such as:\n\nBullying or harassment.\nPosting hate speech or offensive content.\nSharing personal or sensitive information.\nUse the application for illegal purposes.\nWhat happens if I violate the terms of use?\n\nIf you violate the Terms of Use, your account may be permanently banned from the application.\n\nCan I cancel my account?\n\nYes, you can cancel your account at any time.\n\nCan I change my account information?\n\nYes, you can change your account information at any time.\n\nHow can I get help using the application?\n\nYou can review the help center in the application or contact the company that owns the application through https://www.infohub.com/\n\nIs the Howie Hub application safe?\n\nYes, Howie Hub is very secure. We use the latest security technologies to protect users' data.\n\nIs my data shared with anyone else?\n\nNo, your data is not shared with anyone else unless you have expressly agreed to this.\n\nWhat is the privacy policy of the Howie Hub application?\n\nYou can review the Howie Hub privacy policy at https://www.infohub.com/\n\nIs there anything else I should know?\n\nWe advise you to read the terms of use and privacy policy carefully before using the application.\n\nThank you for using Howie Hub!\n\nnote:\nThis FAQ may be updated from time to time. Please check this page periodically to see the latest changes.`
  String get questions {
    return Intl.message(
      'What is the Howie Hub application?\n\nIt is an application that connects stadium owners with tenants, facilitating the process of booking stadiums individually or collectively.\n\nWho can use the Howie Hub application?\n\nAnyone can download and use the app, but it specifically targets young people in Saudi Arabia.\n\nWhat services does the application provide?\n\nBook pitches individually:\nSelect the stadium you want.\nChoose the appropriate date and time.\nComplete the payment process.\nCreate group bookings and share them with friends:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share with your friends.\nCreate group bookings open to all app users:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share it with everyone.\nHow is payment made in the Howie Hub application?\n\nPayment is made by credit card or online payment card.\n\nWhat is the percentage of the company that owns the application of the reservation value?\n\nThe percentage of the reservation value of the company that owns the application varies depending on the type of reservation.\n\nHow can I add a playground to the app?\n\nIf you are a stadium owner, you can contact the company that owns the application through https://www.infohub.com/ to learn more about how to add your stadium to the application.\n\nHow can I contact the company that owns the application?\n\nYou can contact the company that owns the application through https://www.infohub.com/\n\nAre there any restrictions or specific conditions for using the application?\n\nThere are no restrictions or conditions for using the app, but you must respect all users on the app and refrain from any abusive or illegal behavior.\n\nAre there any behaviors prohibited on the application?\n\nYes, there are some behaviors that are prohibited on the application, such as:\n\nBullying or harassment.\nPosting hate speech or offensive content.\nSharing personal or sensitive information.\nUse the application for illegal purposes.\nWhat happens if I violate the terms of use?\n\nIf you violate the Terms of Use, your account may be permanently banned from the application.\n\nCan I cancel my account?\n\nYes, you can cancel your account at any time.\n\nCan I change my account information?\n\nYes, you can change your account information at any time.\n\nHow can I get help using the application?\n\nYou can review the help center in the application or contact the company that owns the application through https://www.infohub.com/\n\nIs the Howie Hub application safe?\n\nYes, Howie Hub is very secure. We use the latest security technologies to protect users\' data.\n\nIs my data shared with anyone else?\n\nNo, your data is not shared with anyone else unless you have expressly agreed to this.\n\nWhat is the privacy policy of the Howie Hub application?\n\nYou can review the Howie Hub privacy policy at https://www.infohub.com/\n\nIs there anything else I should know?\n\nWe advise you to read the terms of use and privacy policy carefully before using the application.\n\nThank you for using Howie Hub!\n\nnote:\nThis FAQ may be updated from time to time. Please check this page periodically to see the latest changes.',
      name: 'questions',
      desc: '',
      args: [],
    );
  }

  /// `Howie Hub application terms and conditions\nintroduction:\n\nWelcome to the Howie Hub app! This application aims to connect stadium owners with tenants, facilitating the process of booking stadiums individually or collectively. Before using the application, please read these terms and conditions carefully.\n\n1. General information:\n\nApplication name: Howie Hub\nApplication type: Sports application\nThe application's target audience: youth in the Kingdom of Saudi Arabia\nServices provided by the application:\nBook pitches individually\nCreate group bookings and share them with friends\nCreate group bookings that are open to all app users\nApplication business model:\nThe user pays the full reservation price.\nThe company that owns the application receives a percentage of ......% of the reservation value after deducting the bank commissions for electronic payment service providers, which are ..........%.\nThe stadium owner gets the rest of the reservation value.\n2. Legal information:\n\nCountry of headquarters of the company that owns the application: Kingdom of Saudi Arabia\n\n3. Privacy Policy:\n\nData collection:\nNormal user:\nthe name\nthe age\nE-mail\nStadium owner:\nSome documents are required to authenticate the stadium owner’s account and documents to prove his ownership of the places before agreeing to display them in the application. All required documents are shown in the legal requirements screen. \ndata usage:\nThese data and documents are kept and the data is only shared with the competent legal authorities only when needed and in accordance with Saudi laws.\nData protection:\nAll legal measures are taken to protect user data.\n4. Terms of use:\nAcceptance of the Terms: Using the application means accepting these terms and conditions.\nthe accounts:\nCreate a free user account.\nVerifying the identity of stadium owners.\nReservations:\nUsers can book pitches individually or as a group.\nThe stadium owner can accept or reject reservations.\nThe reservation value is paid by the user.\nThe company that owns the application receives a percentage of the reservation value.\nThe stadium owner gets the rest of the reservation value.\nBehaviors:\nYou must respect all users on the application and refrain from any abusive or illegal behavior.\nthe responsibility:\nThe user is responsible for all his actions on the application.\nThe Company does not bear any responsibility for any damages resulting from the use of the application.\nthe changes:\nThe Company reserves the right to modify these terms and conditions at any time without prior notice.\nRegulating law:\nThese terms and conditions are subject to the laws of the Kingdom of Saudi Arabia.\n5. Dispute resolution:\nIf any dispute arises between the User and the Application, every effort will be made to resolve it amicably.\nIf the amicable solution fails, arbitration is resorted to at the Commercial Arbitration Center of the Kingdom of Saudi Arabia.\n6. Contact:\n\nYou can contact the company that owns the application through...\nnote:\nThese terms and conditions may be updated from time to time. Please check this page periodically to see the latest changes.\nThank you for using Howie Hub!`
  String get termsAndConditions {
    return Intl.message(
      'Howie Hub application terms and conditions\nintroduction:\n\nWelcome to the Howie Hub app! This application aims to connect stadium owners with tenants, facilitating the process of booking stadiums individually or collectively. Before using the application, please read these terms and conditions carefully.\n\n1. General information:\n\nApplication name: Howie Hub\nApplication type: Sports application\nThe application\'s target audience: youth in the Kingdom of Saudi Arabia\nServices provided by the application:\nBook pitches individually\nCreate group bookings and share them with friends\nCreate group bookings that are open to all app users\nApplication business model:\nThe user pays the full reservation price.\nThe company that owns the application receives a percentage of ......% of the reservation value after deducting the bank commissions for electronic payment service providers, which are ..........%.\nThe stadium owner gets the rest of the reservation value.\n2. Legal information:\n\nCountry of headquarters of the company that owns the application: Kingdom of Saudi Arabia\n\n3. Privacy Policy:\n\nData collection:\nNormal user:\nthe name\nthe age\nE-mail\nStadium owner:\nSome documents are required to authenticate the stadium owner’s account and documents to prove his ownership of the places before agreeing to display them in the application. All required documents are shown in the legal requirements screen. \ndata usage:\nThese data and documents are kept and the data is only shared with the competent legal authorities only when needed and in accordance with Saudi laws.\nData protection:\nAll legal measures are taken to protect user data.\n4. Terms of use:\nAcceptance of the Terms: Using the application means accepting these terms and conditions.\nthe accounts:\nCreate a free user account.\nVerifying the identity of stadium owners.\nReservations:\nUsers can book pitches individually or as a group.\nThe stadium owner can accept or reject reservations.\nThe reservation value is paid by the user.\nThe company that owns the application receives a percentage of the reservation value.\nThe stadium owner gets the rest of the reservation value.\nBehaviors:\nYou must respect all users on the application and refrain from any abusive or illegal behavior.\nthe responsibility:\nThe user is responsible for all his actions on the application.\nThe Company does not bear any responsibility for any damages resulting from the use of the application.\nthe changes:\nThe Company reserves the right to modify these terms and conditions at any time without prior notice.\nRegulating law:\nThese terms and conditions are subject to the laws of the Kingdom of Saudi Arabia.\n5. Dispute resolution:\nIf any dispute arises between the User and the Application, every effort will be made to resolve it amicably.\nIf the amicable solution fails, arbitration is resorted to at the Commercial Arbitration Center of the Kingdom of Saudi Arabia.\n6. Contact:\n\nYou can contact the company that owns the application through...\nnote:\nThese terms and conditions may be updated from time to time. Please check this page periodically to see the latest changes.\nThank you for using Howie Hub!',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Request Accepted`
  String get requestAccepted {
    return Intl.message(
      'Request Accepted',
      name: 'requestAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Request Rejected`
  String get requestRejected {
    return Intl.message(
      'Request Rejected',
      name: 'requestRejected',
      desc: '',
      args: [],
    );
  }

  /// `Please add what is required below from the file`
  String get addRequiredPdf {
    return Intl.message(
      'Please add what is required below from the file',
      name: 'addRequiredPdf',
      desc: '',
      args: [],
    );
  }

  /// `Pick Location`
  String get pickLocation {
    return Intl.message(
      'Pick Location',
      name: 'pickLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location Saved`
  String get locationSaved {
    return Intl.message(
      'Location Saved',
      name: 'locationSaved',
      desc: '',
      args: [],
    );
  }

  /// `There is a conflict with another booking`
  String get bookingConflict {
    return Intl.message(
      'There is a conflict with another booking',
      name: 'bookingConflict',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get passMustContainLowerCase {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'passMustContainLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passMustContainUpperCase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passMustContainUpperCase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get passMustContainSpecialChar {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'passMustContainSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passMustContainNumber {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passMustContainNumber',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout ?`
  String get doYouWantToLogout {
    return Intl.message(
      'Do you want to logout ?',
      name: 'doYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Rates`
  String get rates {
    return Intl.message(
      'Rates',
      name: 'rates',
      desc: '',
      args: [],
    );
  }

  /// `Booking Added Successfully`
  String get bookingSuccess {
    return Intl.message(
      'Booking Added Successfully',
      name: 'bookingSuccess',
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
