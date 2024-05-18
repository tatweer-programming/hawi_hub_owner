part of 'place_cubit.dart';

@immutable
sealed class PlaceState extends Equatable {}

final class PlaceInitial extends PlaceState {
  @override
  List<Object?> get props => [];
}

abstract class PlaceError extends PlaceState {
  final Exception exception;
  PlaceError(this.exception);
}

class CreatePlaceError extends PlaceError {
  CreatePlaceError(super.exception);
  @override
  List<Object?> get props => [];
}

class UploadImagesError extends PlaceError {
  UploadImagesError(super.exception);
  @override
  List<Object?> get props => [];
}

class UpdatePlaceError extends PlaceError {
  UpdatePlaceError(super.exception);
  @override
  List<Object?> get props => [];
}

class DeletePlaceError extends PlaceError {
  DeletePlaceError(super.exception);
  @override
  List<Object?> get props => [];
}

class GetPlacesError extends PlaceError {
  GetPlacesError(super.exception);

  @override
  List<Object?> get props => [];
}

class GetBookingRequestsError extends PlaceError {
  GetBookingRequestsError(super.exception);
  @override
  List<Object?> get props => [];
}

class AcceptBookingRequestError extends PlaceError {
  AcceptBookingRequestError(super.exception);

  @override
  List<Object?> get props => [];
}

class DeclineBookingRequestError extends PlaceError {
  DeclineBookingRequestError(super.exception);
  @override
  List<Object?> get props => [];
}

class GetPlacesLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class GetPlacesSuccess extends PlaceState {
  final List<Place> places;
  GetPlacesSuccess(this.places);
  @override
  List<Object?> get props => [places];
}

class CreatePlaceLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class CreatePlaceSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class UploadImagesLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class UploadImagesSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class UpdatePlaceLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class UpdatePlaceSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class DeletePlaceLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class DeletePlaceSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class GetBookingRequestsLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class GetBookingRequestsSuccess extends PlaceState {
  final List<BookingRequest> bookingRequests;
  GetBookingRequestsSuccess(this.bookingRequests);
  @override
  List<Object?> get props => [bookingRequests];
}

class AcceptBookingRequestLoading extends PlaceState {
  final int requestId;
  AcceptBookingRequestLoading(this.requestId);
  @override
  List<Object?> get props => [];
}

class AcceptBookingRequestSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class DeclineBookingRequestLoading extends PlaceState {
  final int requestId;
  DeclineBookingRequestLoading(this.requestId);
  @override
  List<Object?> get props => [];
}

class DeclineBookingRequestSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class AddImagesSuccess extends PlaceState {
  final List<String> paths;
  AddImagesSuccess(this.paths);
  @override
  List<Object?> get props => [paths];
}

class RemoveImagesSuccess extends PlaceState {
  final String path;
  RemoveImagesSuccess(this.path);
  @override
  List<Object?> get props => [path];
}

class SelectOwnershipFileSuccess extends PlaceState {
  final String path;
  SelectOwnershipFileSuccess(this.path);
  @override
  List<Object?> get props => [];
}

class ChangeWeekEndStatusSuccess extends PlaceState {
  final bool status;
  ChangeWeekEndStatusSuccess(this.status);
  @override
  List<Object?> get props => [status];
}

class CreateBookingLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class CreateBookingSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class CreateBookingError extends PlaceError {
  CreateBookingError(super.exception);
  @override
  List<Object?> get props => [];
}

class GetPlaceReviewsError extends PlaceError {
  GetPlaceReviewsError(super.exception);
  @override
  List<Object?> get props => [];
}

class GetPlaceReviewsSuccess extends PlaceState {
  final List<AppFeedBack> placeReviews;
  GetPlaceReviewsSuccess(this.placeReviews);
  @override
  List<Object?> get props => [placeReviews];
}

class GetPlaceReviewsLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class UploadAttachmentsError extends PlaceError {
  UploadAttachmentsError(super.exception);
  @override
  List<Object?> get props => [];
}

class UploadAttachmentsSuccess extends PlaceState {
  @override
  List<Object?> get props => [];
}

class UploadAttachmentsLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}
