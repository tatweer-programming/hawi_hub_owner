class EndPoints {
  static const String login = '/Owner/Login';
  static const String register = '/Owner/Signup';
  static const String confirmEmail = '/Owner/ConfirmEmail/';
  static const String verifyConfirmEmail = '/Owner/VerifyConfirmEmail/';
  static const String verifyResetCode = '/Owner/VerifyResetCode';
  static const String resetPass = '/Owner/ResetPassword';
  static const String changeImageProfile = '/Owner/ChangeDetails';
  static const String changePassword = '/Owner/ChangePassword';
  static const String verification = '/Owner/Verification';
  static const String uploadProof = '/Owner/UploadProofOfIdentity';
  static const String addPlayerFeedback = "/Owner/AddPlayerReview/";
  static const String getFeedbacks = '/Owner/GetReviews/';

  /// payment
  static const String getAccountBalance = 'v2/GetSupplierDashboard';
  static const String transferBalance = 'v2/TransferBalance';

  /// chat
  static const String getConnection = '/Hub/negotiate?negotiateVersion=1';
  static const String addConnectionId = '/Hub/AddOwnerConnectionId/';

  // static const String getOwnerConversations = '/Hub/OwnerConversations/';
  // static const String getConversation = '/Hub/Conversation/';
  static const String addConversationBetweenPlayerAndOwner =
      '/Hub/ConversationBetweenPlayerAndOwner';
  static const String addConversationBetweenAdminAndOwner =
      '/Hub/ConversationBetweenAdminAndOwner';

  static const String getOwnerConversationsWithPlayers =
      '/Hub/OwnerConversationsWithPlayers/';
  static const String getOwnerConversationsWithAdmins =
      '/Hub/OwnerConversationsWithAdmins/';

  static const String getConversationOwnerWithPlayer =
      '/Hub/ConversationOwnerWithPlayer/';
  static const String getConversationAdminWithOwner =
      '/Hub/ConversationAdminWithOwner/';

  static const String uploadConversationAttachment =
      '/Hub/UploadConversationAttachment';

  ///
  static const String getPlaces = '/Owner/Stadiums/';

  static const String createPlace = '/Stadium/';
  static const String updatePlace = '/Stadium/Update/';
  static const String deletePlace = '/Stadium/';

  static const String getBookingRequest = '/Owner/StadiumsReservations/';
  static const String acceptBookingRequest = '/Owner/AcceptStadiumReservation/';
  static const String declineBookingRequest =
      '/Owner/RejectStadiumReservation/';
  static const String createBooking = '/Stadium/OfflineReservations/';
  static const String getSports = '/Category';
  static const String getBanners = '/Banner';
  static const String getNotifications = '/Hub/OwnerNotifications/';
  static const String getPlaceFeedbacks = '/Stadium/Reviews/';
  static const String uploadProofOfOwnership =
      '/Stadium/UploadStadiumProofOfOwnership';
  static const String uploadPlaceImages = '/Stadium/UploadStadiumImages';
  static const String saveConnectionId = "/Hub/AddOwnerConnectionId/";
  static const String markAsRead = "/Hub/MarkOwnerNotificationAsRead/";
  static const String getPlaceBookings = "/Stadium/StadiumReservationsTimes/";
  static const String addOfflineReservation = "/Stadium/OfflineReservations/";
  static const String saveNotificationToPlayer = "/Hub/AddPlayerNotification/";
  static const String getOfflineBookings =
      "/Owner/StadiumsOfflineReservations/";
}
