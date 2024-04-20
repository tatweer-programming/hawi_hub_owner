part of 'place_cubit.dart';

@immutable
sealed class PlaceState {}

final class PlaceInitial extends PlaceState {}

abstract class PlaceError extends PlaceState {
  final Exception exception;
  PlaceError(this.exception);
}

class CreatePlaceError extends PlaceError {
  CreatePlaceError(super.exception);
}

class UploadImagesError extends PlaceError {
  UploadImagesError(super.exception);
}

class UpdatePlaceError extends PlaceError {
  UpdatePlaceError(super.exception);
}

class DeletePlaceError extends PlaceError {
  DeletePlaceError(super.exception);
}

class GetPlacesError extends PlaceError {
  GetPlacesError(super.exception);
}

class GetBookingRequestsError extends PlaceError {
  GetBookingRequestsError(super.exception);
}

class AcceptBookingRequestError extends PlaceError {
  AcceptBookingRequestError(super.exception);
}

class DeclineBookingRequestError extends PlaceError {
  DeclineBookingRequestError(super.exception);
}

class GetPlacesLoading extends PlaceState {}

class GetPlacesSuccess extends PlaceState {
  final List<Place> places;
  GetPlacesSuccess(this.places);
}

class CreatePlaceLoading extends PlaceState {}

class CreatePlaceSuccess extends PlaceState {}

class UploadImagesLoading extends PlaceState {}

class UploadImagesSuccess extends PlaceState {}

class UpdatePlaceLoading extends PlaceState {}

class UpdatePlaceSuccess extends PlaceState {}

class DeletePlaceLoading extends PlaceState {}

class DeletePlaceSuccess extends PlaceState {}

class GetBookingRequestsLoading extends PlaceState {}

class GetBookingRequestsSuccess extends PlaceState {
  final List<BookingRequest> bookingRequests;
  GetBookingRequestsSuccess(this.bookingRequests);
}

class AcceptBookingRequestLoading extends PlaceState {}

class AcceptBookingRequestSuccess extends PlaceState {}

class DeclineBookingRequestLoading extends PlaceState {}

class DeclineBookingRequestSuccess extends PlaceState {}
