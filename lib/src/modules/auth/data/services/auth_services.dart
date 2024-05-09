import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';

import '../../../../core/apis/dio_helper.dart';
import '../../../../core/apis/end_points.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/utils/constance_manager.dart';
import '../models/auth_owner.dart';

class AuthService {
  Future<String> registerPlayer({
    required AuthOwner authOwner,
  }) async {
    try {
      FormData map = FormData.fromMap({
        'Email': authOwner.email,
        'Username': authOwner.userName,
        'Password': authOwner.password,
      });
      print(authOwner.profilePictureUrl);
      if (authOwner.profilePictureUrl != null) {
        map.fields.add(
          MapEntry(
            'ProfilePicture',
            authOwner.profilePictureUrl!,
          ),
        );
      }
      print(map.files);
      Response response = await DioHelper.postData(
        data: map,
        path: EndPoints.register,
      );
      print(response.data.toString());
      if (response.statusCode == 200) {
        ConstantsManager.userId = response.data['id'];
        await CacheHelper.saveData(key: 'id', value: response.data['id']);
        return response.data['message'];
      }
      return response.data.toString();
    } catch (e) {
      return "CHECK YOUR NETWORK";
    }
  }

  Future<String> loginOwner(
      {required String email,
      required String password,
      required bool loginWithFBOrGG}) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'Email': email,
          'Password': password,
          'loginWithFBOrGG': loginWithFBOrGG
        },
        path: EndPoints.login,
      );
      if (response.statusCode == 200) {
        ConstantsManager.userId = response.data['id'];
        await CacheHelper.saveData(key: 'id', value: response.data['id']);
        return response.data['message'];
      }
      return response.data.toString();
    } catch (e) {
      return "CHECK YOUR NETWORK";
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
      print("ERORR $e");
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
      await googleSignIn.signOut();
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        await loginOwner(
            email: googleUser.email, password: "string", loginWithFBOrGG: true);
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
        final userData = await FacebookAuth.instance.getUserData();
        await loginOwner(
            email: userData['email'],
            password: "string",
            loginWithFBOrGG: true);
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'email': email,
        },
        path: EndPoints.resetPass,
      );
      return response.data.toString();
    } catch (e) {
      return "CHECK YOUR NETWORK";
    }
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        path: "${EndPoints.changePassword}/${ConstantsManager.userId}",
      );
      if (response.statusCode == 200) {
        return response.data['message'];
      }
      return response.data.toString();
    } catch (e) {
      print("object $e");
      return "CHECK YOUR NETWORK";
    }
  }

  /// TODO
  Future<String> changeProfileImage(File newProfileImage) async {
    try {
      Response response = await DioHelper.putDataFormData(
        token: ConstantsManager.userId.toString(),
        data: FormData.fromMap({'ProfilePicture': newProfileImage}),
        path: EndPoints.changeImageProfile,
      );
      if (response.statusCode == 200) {
        return "Profile image updated successfully";
        return (response.data['message']);
      }
      return (response.data.toString());
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> uploadNationalId(File nationalId) async {
    try {
      print("object");
      Response response = await DioHelper.postFormData(
        "${EndPoints.verification}/${ConstantsManager.userId}",
        FormData.fromMap(
            {'proofOfIdentity': MultipartFile.fromFileSync(nationalId.path)}),
      );
      if (response.statusCode == 200) {
        print(response.data);
        print("Success");
        return "Proof of identity has been added successfully";
      }
      return (response.data.toString());
    } catch (e) {
      print(e);
      return "Something went wrong";
    }
  }

  // Future<String> deleteProfileImage() async {
  //   try {
  //     Response response = await DioHelper.deleteData(
  //       token: ConstantsManager.userId.toString(),
  //       path: EndPoints.deleteProfile,
  //     );
  //     if (response.statusCode == 200) {
  //       return "Profile image deleted";
  //     }
  //     return (response.data['msg']);
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  Future<String> verifyCode({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      print(email);
      print(code);
      print(password);
      Response response = await DioHelper.postData(
        data: {
          "resetCode": code,
          "email": email,
          "newPassword": password,
        },
        path: EndPoints.verifyResetCode,
      );
      if(response.statusCode == 200) {
        await loginOwner(email: email, password: password, loginWithFBOrGG: false);
        return (response.data['message']);
      }
      return (response.data.toString());
    } catch (e) {
      print("e $e");
      return "CHECK YOUR NETWORK";
    }
  }

  Future<Either<String, Owner>> getProfile(int id) async {
    try {
      Response response = await DioHelper.getData(
        path: "/Owner/$id",
      );
      Owner owner = Owner.fromJson(response.data);
      return Right(owner);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
