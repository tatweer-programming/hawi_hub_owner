import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
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
    Day(
      dayId: 0,
      endTime: 20,
      startTime: 8,
    ),
    Day(
      dayId: 1,
      endTime: 20,
      startTime: 8,
    ),
    Day(
      dayId: 2,
      endTime: 20,
      startTime: 8,
    ),
    Day(
      dayId: 3,
      endTime: 20,
      startTime: 8,
    ),
    Day(
      dayId: 4,
      endTime: 20,
      startTime: 8,
    ),
    Day(
      dayId: 5,
      endTime: 20,
      startTime: 8,
    ),
    Day(
      dayId: 6,
      endTime: 20,
      startTime: 8,
    ),
  ];
  int? selectedCityId;
  String? selectedSport;
  List<File> imageFiles = [];
  File? selectedOwnershipFile;
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
    var uploadImagesResult = await uploadPlaceImages(placeCreationForm.imageFiles);
    uploadImagesResult.fold((l) {}, (r) async {
      var createPlaceResult = await dataSource.createPlace(placeCreationForm);
      createPlaceResult.fold((l) {
        emit(CreatePlaceError(l));
      }, (r) {
        emit(CreatePlaceSuccess());
      });
    });
  }

  Future<Either<Exception, List<String>>> uploadPlaceImages(List<File> images) async {
    emit(UploadImagesLoading());
    var result = await dataSource.uploadImages(images);
    result.fold((l) {
      emit(UploadImagesError(l));
    }, (r) {
      emit(UploadImagesSuccess());
    });
    return result;
  }

  Future updatePlace(int placeId, {required PlaceCreationForm newPlace}) async {
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
    emit(AddImagesSuccess());
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
}
