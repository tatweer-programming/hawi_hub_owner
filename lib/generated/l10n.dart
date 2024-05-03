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

  /// `No ratings found`
  String get noRatings {
    return Intl.message(
      'No ratings found',
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
