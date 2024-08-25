import 'dart:io';

import 'package:dartz/dartz.dart';
import '../models/auth_owner.dart';
import '../models/owner.dart';
import '../services/auth_services.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<String> loginPlayer(
      {required String email,
      required String password,
      required bool loginWithFBOrGG}) async {
    return await _service.loginOwner(
        email: email, password: password, loginWithFBOrGG: loginWithFBOrGG);
  }

  Future<Either<String, String>> loginWithGoogle() async {
    return await _service.loginWithGoogle();
  }

  Future<Either<String, String>> loginWithFacebook() async {
    return await _service.loginWithFacebook();
  }

  Future<Either<String, AuthOwner?>> signupWithGoogle() async {
    return await _service.signupWithGoogle();
  }

  Future<Either<String, AuthOwner?>> signupWithFacebook() async {
    return await _service.signupWithFacebook();
  }

  Future<Either<String, String>> confirmEmail() async {
    return await _service.confirmEmail();
  }

  Future<Either<String, String>> verifyConfirmEmail(String code) async {
    return await _service.verifyConfirmEmail(code);
  }

  Future<Either<String, String>> registerPlayer({
    required AuthOwner authOwner,
  }) async {
    return _service.registerOwner(
      authOwner: authOwner,
    );
  }

  Future<String> resetPassword(String email) async {
    return _service.resetPassword(email);
  }

  Future<String> changeProfileImage(File newProfileImage) async {
    return _service.changeProfileImage(newProfileImage);
  }

  Future<Either<String, String>> uploadNationalId(File nationalId) async {
    return _service.verificationNationalId(nationalId);
  }

  Future<Either<String, String>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return _service.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  // Future<String> deleteProfileImage() async {
  //   return _service.deleteProfileImage();
  // }

  Future<Either<String, String>> verifyCode({
    required String email,
    required String code,
    required String password,
  }) async {
    return _service.verifyCode(email: email, code: code, password: password);
  }

  Future<Either<String, Owner>> getProfile(int id) async {
    return _service.getProfile(id);
  }
}
