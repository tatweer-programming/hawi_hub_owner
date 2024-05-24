class EndPoints {
  static const String login = '/Owner/Login';
  static const String register = '/Owner/Signup';
  static const String verifyResetCode = '/Owner/VerifyResetCode';
  static const String resetPass = '/Owner/ResetPassword';
  static const String changeImageProfile = '/Owner/ChangeDetails';
  static const String changePassword = '/Owner/ChangePassword';
  static const String verification = '/Owner/Verification';

  ///
  static const String chat = '/chat/negotiate?negotiateVersion=1';

  ///
  static const String getPlaces = 'Owner/GetStadiums/';

  static const String createPlace = 'Stadium/Add';
  static const String updatePlace = '/Stadium/Update/';
  static const String deletePlace = '/Stadium/Delete/';
  static const String uploadImages = '/uploadimage';
  static const String getBookingRequest = '/Stadium/GetOwnerStadiumsReservations/';
  static const String getPlaceReservations = '/Stadium/GetReservations';
  static const String acceptBookingRequest = '/Owner/AcceptStadiumReservation/';
  static const String declineBookingRequest = '/Owner/RejectStadiumReservation/';
  static const String createBooking = '/createbookingrequest';
  static const String getSports = '/Category';
  static const String getBanners = '/Banner';
  static const String getNotifications = '/Notification';
  static const String getPlaceFeedbacks = '/Stadium/GetFeedbacks/';
  static const String uploadProofOfOwnership = '/Stadium/UploadStadiumProofOfOwnership';
  static const String uploadPlaceImages = '/Stadium/UploadStadiumImages';
}
