import 'package:dartz/dartz.dart';
import '../models/auth_owner.dart';
import '../models/owner.dart';
import '../models/sport.dart';
import '../services/auth_services.dart';

class AuthRepository {
  final AuthService _service = AuthService();
  Future<String> loginPlayer(String email, String password) async {
    return await _service.loginPlayer(email, password);
  }

  Future<Either<String, bool>> loginWithGoogle() async {
    return await _service.loginWithGoogle();
  }

  Future<Either<String, bool>>loginWithFacebook() async {
    return await _service.loginWithFacebook();
  }

  Future<Either<String, AuthOwner?>> signupWithGoogle() async {
    return await _service.signupWithGoogle();
  }

  Future<Either<String, AuthOwner?>>  signupWithFacebook() async {
    return await _service.signupWithFacebook();
  }

  Future<String> registerPlayer({
    required AuthOwner authOwner,
  }) async {
    return _service.registerPlayer(authOwner: authOwner,);
  }

  Future<String> verifyCode(String email) async {
    return _service.verifyCode(email);
  }

  Future<String> changeProfileImage(String newProfileImage) async {
    return _service.changeProfileImage(newProfileImage);
  }

  Future<String> deleteProfileImage() async {
    return _service.deleteProfileImage();
  }

  Future<String> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    return _service.resetPassword(email: email, code: code, password: password);
  }

  Future<Either<String, List<Sport>>> getSports() async {
    return _service.getSports();
  }

  Future<Either<String, Owner>> getProfile(int id) async {
    return _service.getProfile(id);
  }
}
