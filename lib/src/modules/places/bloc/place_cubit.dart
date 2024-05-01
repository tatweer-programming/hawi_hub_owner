import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
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
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
    const Day(
      dayOfWeek: 1,
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
    const Day(
      dayOfWeek: 2,
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
    const Day(
      dayOfWeek: 3,
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
    const Day(
      dayOfWeek: 4,
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
    const Day(
      dayOfWeek: 5,
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
    const Day(
      dayOfWeek: 6,
      endTime: TimeOfDay(hour: 00, minute: 00),
      startTime: TimeOfDay(hour: 23, minute: 59),
    ),
  ];
  int? selectedCityId;
  String? selectedSport;
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
        print("getPlaces");
        places = r;
        print(places.length);
        isPlacesLoading = false;
        emit(GetPlacesSuccess(r));
      });
    }
  }

  Future createPlace(PlaceCreationForm placeCreationForm) async {
    emit(CreatePlaceLoading());
    var createPlaceResult = await dataSource.createPlace(placeCreationForm);
    createPlaceResult.fold((l) {
      emit(CreatePlaceError(l));
    }, (r) {
      emit(CreatePlaceSuccess());
    });
  }

  Future updatePlace(int placeId, {required PlaceEditForm newPlace}) async {
    emit(UpdatePlaceLoading());
    var result = await dataSource.updatePlace(placeId, newPlace: newPlace);
    result.fold((l) {
      emit(UpdatePlaceError(l));
    }, (r) {
      emit(UpdatePlaceSuccess());
    });
  }

  Future deletePlace(int placeId) async {
    emit(DeletePlaceLoading());
    var result = await dataSource.deletePlace(placeId);
    result.fold((l) {
      emit(DeletePlaceError(l));
    }, (r) {
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
    emit(AcceptBookingRequestLoading());
    var result = await dataSource.acceptBookingRequest(requestId);
    result.fold((l) {
      emit(AcceptBookingRequestError(l));
    }, (r) {
      emit(AcceptBookingRequestSuccess());
    });
  }

  Future declineBookingRequest(int requestId) async {
    emit(DeclineBookingRequestLoading());
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
    selectedSport = null;
    selectedCityId = null;
    imageFiles.clear();
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
    print(placeEditForm!.images);
    placeEditForm!.images.removeWhere((element) => element == image);
    emit(RemoveImagesSuccess(image));
  }
}
