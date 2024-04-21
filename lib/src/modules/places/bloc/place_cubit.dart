import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
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
}
