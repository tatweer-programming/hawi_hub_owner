import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';

import '../../../../core/apis/dio_helper.dart';
import '../../../../core/apis/end_points.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/utils/constance_manager.dart';
import '../models/auth_owner.dart';
import '../models/sport.dart';

class AuthService {
  Future<String> registerPlayer({
    required AuthOwner authOwner,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': authOwner.email,
          'user_name': authOwner.userName,
          'pass': authOwner.password,
          'image': authOwner.profilePictureUrl
        },
        path: EndPoints.register,
      );
      if (response.statusCode == 200) {
        ConstantsManager.userId = response.data['data']['id'];
        ConstantsManager.userToken = response.data['token'].toString();
        await CacheHelper.saveData(key: 'token', value: response.data['token']);
        await CacheHelper.saveData(
            key: 'id', value: response.data['data']['id']);
        return "Registration Successful";
      }
      return "Registration Failed";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> loginPlayer(String email, String password) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'pass': password,
        },
        path: EndPoints.login,
      );
      if (response.statusCode == 200) {
        ConstantsManager.userToken = response.data['data']['id'];
        await CacheHelper.saveData(key: 'token', value: response.data['token']);
        return "Login Successfully";
      }
      return "Login Failed";
    } catch (e) {
      return "Invalid email or password";
    }
  }

  Future<Either<String, AuthOwner?>> signupWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      await googleSignIn.signOut();
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        AuthOwner authPlayer = AuthOwner(
          email: googleUser.email,
          userName: googleUser.displayName!,
          profilePictureUrl: googleUser.photoUrl,
          password: '',
        );
        return Right(authPlayer);
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, AuthOwner?>> signupWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      Map<String, dynamic>? userData;
      if (result.status == LoginStatus.success) {
        userData = await FacebookAuth.instance.getUserData();
      }
      if (result.status == LoginStatus.success && userData != null) {
        AuthOwner authPlayer = AuthOwner(
          email: userData['email'],
          userName: userData['name'],
          profilePictureUrl: userData['picture']['data']['url']!,
          password: '',
        );
        return Right(authPlayer);
      }
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> verifyCode(String email) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
        },
        path: EndPoints.verifyCode,
      );
      if (response.statusCode == 200) {
        return "Code Sent";
      }
      return "No account for this user";
    } catch (e) {
      print("object $e");
      return e.toString();
    }
  }

  Future<String> changeProfileImage(String newProfileImage) async {
    try {
      Response response = await DioHelper.putData(
        token: ConstantsManager.userToken,
        data: {
          'image': newProfileImage,
        },
        path: EndPoints.changeProfile,
      );
      if (response.statusCode == 200) {
        return "Profile image updated successfully";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteProfileImage() async {
    try {
      Response response = await DioHelper.deleteData(
        token: ConstantsManager.userToken,
        path: EndPoints.deleteProfile,
      );
      if (response.statusCode == 200) {
        return "Profile image deleted";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'code': code,
          'pass': password,
        },
        path: EndPoints.resetPass,
      );
      if (response.statusCode == 200) {
        return "Password Reset Successful";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<Either<String, List<Sport>>> getSports() async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getSports,
      );
      List<Sport> sports = [];
      for (var category in response.data) {
        sports.add(Sport.fromJson(category));
      }
      return Right(sports);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, Owner>> getProfile(int id) async {
    try {
      Response response = await DioHelper.getData(
        path: "${EndPoints.getProfile}/$id",
      );
      Owner player;
      player = Owner.fromJson(response.data);
      return Right(player);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
