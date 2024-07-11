class AuthOwner {
  final String userName;
  final String email;
  final String password;
  final String? profilePictureUrl;

  AuthOwner({
    required this.password,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
  });
  Map<String, dynamic> toJson(){
    return {
      "userName": userName,
      "email": email,
      "password": password,
      // "profilePictureUrl": profilePictureUrl
    };
  }
}
