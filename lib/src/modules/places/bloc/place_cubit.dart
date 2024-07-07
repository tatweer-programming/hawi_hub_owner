import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/main/data/services/notification_services.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/localization_manager.dart';
import '../data/models/booking.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit() : super(PlaceInitial());

  static PlaceCubit? cubit;

  static PlaceCubit get() {
    cubit ??= PlaceCubit();
    return cubit!;
  }

  Place? currentPlace;
  PlaceRemoteDataSource dataSource = PlaceRemoteDataSource();
  List<Place> places = [];
  List<BookingRequest> bookingRequests = [];
  bool isPlacesLoading = true;
  bool isBookingRequestsLoading = true;

  /// adding place
  PlaceLocation? placeLocation;
  List<Day> workingHours = [
    const Day(
      dayOfWeek: 0,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
    const Day(
      dayOfWeek: 1,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
    const Day(
      dayOfWeek: 2,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
    const Day(
      dayOfWeek: 3,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
    const Day(
      dayOfWeek: 4,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
    const Day(
      dayOfWeek: 5,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
    const Day(
      dayOfWeek: 6,
      endTime: TimeOfDay(hour: 23, minute: 59),
      startTime: TimeOfDay(hour: 00, minute: 00),
    ),
  ];
  int? selectedCityId;
  int? selectedSport;
  List<File> imageFiles = [];
  File? selectedOwnershipFile;

  PlaceEditForm? placeEditForm;

  void getPlaces() async {
    if (places.isEmpty) {
      emit(GetPlacesLoading());
      var result = await dataSource.getPlaces();
      result.fold((l) {
        isPlacesLoading = false;
        emit(GetPlacesError(l));
      }, (r) {
        //print("getPlaces");
        places = r;
        print(places.map((e) => e.location).toList());
        isPlacesLoading = false;
        emit(GetPlacesSuccess(r));
      });
    }
  }

  Future createPlace(PlaceCreationForm placeCreationForm) async {
    String ownershipUrl = "";
    List<String> imagesUrl = [];
    debugPrint("creating place");
    emit(UploadAttachmentsLoading());
    var ownershipResult =
        await _uploadProofOfOwnership(file: selectedOwnershipFile!);
    ownershipResult.fold((l) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      emit(UploadAttachmentsError(l));
    }, (r) {
      print(r);
      ownershipUrl = r;
    });
    var imageResult = await _uploadPlaceImages(files: imageFiles);
    imageResult.fold((l) {
      print(
          "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
      emit(UploadAttachmentsError(l));
    }, (r) {
      print(r);
      imagesUrl = r;
    });
    if (ownershipUrl != "" && imagesUrl.isNotEmpty) {
      placeCreationForm.setAttachments(imagesUrl, ownershipUrl);
      print(placeCreationForm.ownershipUrl);
      emit(CreatePlaceLoading());
      var createPlaceResult = await dataSource.createPlace(placeCreationForm);
      createPlaceResult.fold((l) {
        emit(CreatePlaceError(l));
      }, (r) {
        emit(CreatePlaceSuccess());
        getPlaces();
      });
    }
  }

  Future updatePlace(int placeId, {required PlaceEditForm newPlace}) async {
    if (newPlace.imageFiles.isNotEmpty) {
      emit(UploadAttachmentsLoading());
      var imageResult = await _uploadPlaceImages(files: newPlace.imageFiles);
      imageResult.fold((l) {
        print(
            "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
        emit(UploadAttachmentsError(l));
      }, (r) {
        List<String> imagesUrl = newPlace.images;
        print(imagesUrl);
        print(r);
        imagesUrl.addAll(r);
        newPlace.updateImages(imagesUrl);
        print(newPlace.images);
      });
    }
    emit(UpdatePlaceLoading());
    var result = await dataSource.updatePlace(placeId, newPlace: newPlace);
    result.fold((l) {
      emit(UpdatePlaceError(l));
    }, (r) {
      emit(UpdatePlaceSuccess());
    });
    clearSelectedData();
    getPlaces();
  }

  Future deletePlace(int placeId) async {
    emit(DeletePlaceLoading());
    var result = await dataSource.deletePlace(placeId);
    result.fold((l) {
      emit(DeletePlaceError(l));
    }, (r) {
      places.removeWhere((element) => element.id == placeId);
      emit(DeletePlaceSuccess());
    });
  }

  Future getBookingRequests() async {
    if (bookingRequests.isEmpty) {
      emit(GetBookingRequestsLoading());
      var result = await dataSource.getBookingRequests();
      result.fold((l) {
        isBookingRequestsLoading = false;
        emit(GetBookingRequestsError(l));
      }, (r) {
        bookingRequests = r;
        isBookingRequestsLoading = false;
        emit(GetBookingRequestsSuccess(r));
      });
    }
  }

  Future acceptBookingRequest(int requestId) async {
    emit(AcceptBookingRequestLoading(requestId));
    var result = await dataSource.acceptBookingRequest(requestId);
    result.fold((l) {
      //print(l);
      emit(AcceptBookingRequestError(l));
    }, (r) async {
      List<int> ids = _getPlayersIdsFromRequest(requestId);
      bookingRequests.removeWhere((element) => element.id == requestId);
      emit(AcceptBookingRequestSuccess());
      _sendRequestNotifications(ids, true, requestId);
    });
  }

  Future declineBookingRequest(int requestId) async {
    emit(DeclineBookingRequestLoading(requestId));
    var result = await dataSource.declineBookingRequest(requestId);
    result.fold((l) {
      emit(DeclineBookingRequestError(l));
    }, (r) async {
      List<int> ids = _getPlayersIdsFromRequest(requestId);
      bookingRequests.removeWhere((element) => element.id == requestId);
      emit(DeclineBookingRequestSuccess());
      _sendRequestNotifications(ids, false, requestId);
    });
  }

  Future addImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'wbmp', 'webp'],
    );

    if (result != null) {
      if (result.files.isNotEmpty) {
        imageFiles.addAll(result.files.map((e) => File(e.path!)));
        emit(AddImagesSuccess(imageFiles.map((e) => e.path).toList()));
      }
    } else {
      // User canceled the picker
    }
  }

  void removeImage(String image) {
    imageFiles.removeWhere((element) => element.path == image);
    emit(RemoveImagesSuccess(image));
  }

  Future selectOwnershipFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // if size > 5MB
      if (result.files.single.size > 10 * 1024 * 1024) {
        errorToast(
            msg: LocalizationManager.getCurrentLocale().languageCode == "en"
                ? "File size should be less than 10 MB"
                : "يجب ان يكون حجم الملف اقل  من 10MB");
      } else {
        selectedOwnershipFile = File(result.files.single.path!);
        emit(SelectOwnershipFileSuccess(selectedOwnershipFile!.path));
      }
    } else {
      // User canceled the picker
    }
  }

  void prepareEditForm(int placeId) {
    clearSelectedData();
    placeEditForm =
        places.firstWhere((element) => element.id == placeId).createEditForm();
  }

  Future addImagesToEditForm() async {
    ImagePicker imagePicker = ImagePicker();
    List<XFile>? images = await imagePicker.pickMultiImage();
    placeEditForm!.imageFiles.addAll(images.map((e) => File(e.path)).toList());
    emit(AddImagesSuccess(
        placeEditForm!.imageFiles.map((e) => e.path).toList()));
  }

  void removeImageFromEditForm(String image) {
    placeEditForm!.imageFiles.removeWhere((element) => element.path == image);
    emit(RemoveImagesSuccess(image));
  }

  void removeNetworkImageFromEditForm(String image) {
    //print(placeEditForm!.images);
    placeEditForm!.images.removeWhere((element) => element == image);
    emit(RemoveImagesSuccess(image));
  }

  createBooking(
      DateTime bookingStartTime, DateTime bookingEndTime, int placeId) async {
    emit(CreateBookingLoading());
    var result = await dataSource.createBooking(
      placeId: placeId,
      bookingStartTime: bookingStartTime,
      bookingEndTime: bookingEndTime,
    );
    result.fold((l) {
      emit(CreateBookingError(l));
    }, (r) {
      emit(CreateBookingSuccess());
    });
  }

  Future getPlaceFeedbacks(int placeId) async {
    emit(GetPlaceReviewsLoading());
    var result = await dataSource.getPlaceFeedbacks(placeId);
    result.fold((l) {
      emit(GetPlaceReviewsError(l));
    }, (r) {
      currentPlace!.feedbacks = r;
      emit(GetPlaceReviewsSuccess(r));
    });
  }

  Future<Either<Exception, String>> _uploadProofOfOwnership(
      {required File file}) async {
    return await dataSource.uploadProfFile(file: file);
  }

  Future<Either<Exception, List<String>>> _uploadPlaceImages(
      {required List<File> files}) async {
    return await dataSource.uploadPlaceImages(files: files);
  }

  void chooseSport(String newSport) {
    selectedSport = MainCubit.get()
        .sportsList
        .firstWhere((element) => element.name == newSport)
        .id;
  }

  void pickLocation(PlaceLocation location, {required String address}) {
    placeLocation = location;
    emit(PickLocationSuccess(address));
  }

  void clearSelectedData() {
    selectedSport = null;
    selectedCityId = null;
    imageFiles.clear();
  }

  getPlaceBookings({required int placeId}) async {
    print("getting place bookings");
    emit(GetPlaceBookingsLoading());
    var result = await dataSource.getPlaceBookings(placeId: placeId);
    result.fold((l) {
      print("error getting place bookings ${l.toString()}");
      emit(GetPlaceBookingsError(l));
    }, (r) {
      print("got place bookings ${r.toString()}");
      emit(GetPlaceBookingsSuccess(r));
    });
  }

  addOfflineReservation(
      {required int placeId, required Booking booking}) async {
    print("adding offline reservation ${booking.toJson()}");
    emit(AddOfflineReservationLoading());
    var result = await dataSource.addOfflineReservation(
        booking: booking, placeId: placeId);
    result.fold((l) {
      emit(AddOfflineReservationError(l));
    }, (r) {
      emit(AddOfflineReservationSuccess());
    });
  }

  Future addPlayerFeedback(
      {required AppFeedBack feedback, required int ownerId}) async {
    emit(AddPlayerFeedbackLoading());
    var result =
        await dataSource.addPlayerFeedback(ownerId: ownerId, review: feedback);
    result.fold((l) {
      emit(AddPlayerFeedbackError(l));
    }, (r) {
      emit(AddPlayerFeedbackSuccess());
    });
  }

  void addRating(double rate) {
    emit(AddRatingState(rate));
  }

  String _getPlaceNameFromRequestId(int requestId) {
    int placeId = bookingRequests
        .firstWhere((element) => element.id == requestId)
        .placeId;
    return places.firstWhere((element) => element.id == placeId).name;
  }

  List<int> _getPlayersIdsFromRequest(int requestId) {
    List<int> ids = [];
    BookingRequest bookingRequest =
        bookingRequests.firstWhere((element) => element.id == requestId);
    ids.add(bookingRequest.userId);
    if (bookingRequest.players != null) {
      ids.addAll(bookingRequest.players!.map((e) => e.id));
    }
    return ids;
  }

  void _sendRequestNotifications(
      List<int> ids, bool isAccepted, int requestId) async {
    if (isAccepted) {
      for (int id in ids) {
        await NotificationServices().sendNotification(AppNotification(
            title: "تم قبول طلبك",
            body:
                ": ${_getPlaceNameFromRequestId(requestId)}تم قبول طلب حجز الملعب",
            id: id,
            receiverId: id));
      }
    } else {
      for (int id in ids) {
        await NotificationServices().sendNotification(AppNotification(
            title: "تم رفض طلبك",
            body:
                ": ${_getPlaceNameFromRequestId(requestId)}تم رفض طلب حجز الملعب",
            id: id,
            receiverId: id));
      }
    }
  }
}
