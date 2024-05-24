import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/sport.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';
import 'package:image_picker/image_picker.dart';
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
        //print(places.length);
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
    var ownershipResult = await _uploadProofOfOwnership(file: selectedOwnershipFile!);
    ownershipResult.fold((l) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      emit(UploadAttachmentsError(l));
    }, (r) {
      print(r);
      ownershipUrl = r;
    });
    var imageResult = await _uploadPlaceImages(files: imageFiles);
    imageResult.fold((l) {
      print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
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
      });
    }
  }

  Future updatePlace(int placeId, {required PlaceEditForm newPlace}) async {
    List<String> imagesUrl = newPlace.images;
    if (newPlace.imageFiles.isNotEmpty) {
      emit(UploadAttachmentsLoading());
      var imageResult = await _uploadPlaceImages(files: imageFiles);
      imageResult.fold((l) {
        print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
        emit(UploadAttachmentsError(l));
      }, (r) {
        print(r);
        imagesUrl.addAll(r);
        newPlace.updateImages(imagesUrl);
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
    }, (r) {
      //print(r);
      emit(AcceptBookingRequestSuccess());
    });
  }

  Future declineBookingRequest(int requestId) async {
    emit(DeclineBookingRequestLoading(requestId));
    var result = await dataSource.declineBookingRequest(requestId);
    result.fold((l) {
      emit(DeclineBookingRequestError(l));
    }, (r) {
      emit(DeclineBookingRequestSuccess());
    });
  }

  Future addImages() async {
    ImagePicker imagePicker = ImagePicker();
    List<XFile>? images = await imagePicker.pickMultiImage();
    imageFiles.addAll(images.map((e) => File(e.path)).toList());
    emit(AddImagesSuccess(imageFiles.map((e) => e.path).toList()));
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
      selectedOwnershipFile = File(result.files.single.path!);
      emit(SelectOwnershipFileSuccess(selectedOwnershipFile!.path));
    } else {
      // User canceled the picker
    }
  }

  void prepareEditForm(int placeId) {
    clearSelectedData();
    placeEditForm = places.firstWhere((element) => element.id == placeId).createEditForm();
  }

  Future addImagesToEditForm() async {
    ImagePicker imagePicker = ImagePicker();
    List<XFile>? images = await imagePicker.pickMultiImage();
    placeEditForm!.imageFiles.addAll(images.map((e) => File(e.path)).toList());
    emit(AddImagesSuccess(placeEditForm!.imageFiles.map((e) => e.path).toList()));
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

  createBooking(DateTime bookingStartTime, DateTime bookingEndTime, int placeId) async {
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

  Future<Either<Exception, String>> _uploadProofOfOwnership({required File file}) async {
    return await dataSource.uploadProfFile(file: file);
  }

  Future<Either<Exception, List<String>>> _uploadPlaceImages({required List<File> files}) async {
    return await dataSource.uploadPlaceImages(files: files);
  }

  void chooseSport(String newSport) {
    selectedSport = MainCubit.get().sportsList.firstWhere((element) => element.name == newSport).id;
  }

  void clearSelectedData() {
    selectedSport = null;
    selectedCityId = null;
    imageFiles.clear();
  }
}
