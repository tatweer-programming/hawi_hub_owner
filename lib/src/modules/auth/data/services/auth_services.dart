import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';

import '../../../../core/apis/dio_helper.dart';
import '../../../../core/apis/end_points.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/utils/constance_manager.dart';
import '../models/auth_owner.dart';

class AuthService {
  Future<Either<Exception, String>> register({
    required AuthOwner authOwner,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: authOwner.toJson(),
        path: EndPoints.register,
      );
      ConstantsManager.userId = response.data['id'];
      return Right(response.data['message']);
    } on Exception catch (e) {
      print(e);
      return Left(e);
    }
  }

  Future<Either<Exception, String>> confirmEmail() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.confirmEmail + ConstantsManager.userId.toString(),
      );
      return Right(response.data.toString());
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> verifyConfirmEmail(String code) async {
    try {
      Response response = await DioHelper.postData(
        data: {"confirmEmailCode": code},
        path: EndPoints.verifyConfirmEmail + ConstantsManager.userId.toString(),
      );
      await CacheHelper.saveData(key: 'userId', value: ConstantsManager.userId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> login(
      {required String email,
        required String password,
        required bool loginWithFBOrGG}) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          "email": email,
          "password": password,
          "loginWithFBOrGG": loginWithFBOrGG
        },
        path: EndPoints.login,
      );
      if (response.data != "Email is not exists.") {
        ConstantsManager.userId = response.data['id'];
        await CacheHelper.saveData(key: 'userId', value: response.data['id']);
        return Right(response.data['message']);
      }
      return Left(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, AuthOwner?>> signupWithGoogle() async {
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
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      await googleSignIn.signOut();
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final message = await login(
          email: googleUser.email,
          password: "string",
          loginWithFBOrGG: true,
        );
        message.fold(
              (l) {
            return Left(l);
          },
              (r) {
            return Right(message);
          },
        );
      }
      return const Right("Something went wrong");
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, AuthOwner?>> signupWithFacebook() async {
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
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();

        final message = await login(
          email: userData['email'],
          password: "string",
          loginWithFBOrGG: true,
        );
        message.fold(
              (l) {
            return Left(l);
          },
              (r) {
            return Right(message);
          },
        );
      }
      return const Right("Something went wrong");
    } on Exception catch (e) {
      return Left(e);
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
    } on DioException catch (e) {
      return e.response.toString();
    }
  }

  Future<Either<Exception, String>> changePassword({
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
      return Right(response.data['message']);
    } on Exception catch (e) {
      return Left(e);
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
      }
      return (response.data.toString());
    } on DioException catch (e) {
      return e.response.toString();
    }
  }

  Future<Either<Exception, String>> verificationNationalId(
      File nationalId) async {
    try {
      String nationalIdUrl = await _uploadNationalId(nationalId);
      Response response = await DioHelper.postData(
          path: "${EndPoints.verification}/${ConstantsManager.userId}",
          data: {"proofOfIdentityUrl": nationalIdUrl});
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<String> _uploadNationalId(File nationalId) async {
    try {
      Response response = await DioHelper.postFormData(
        EndPoints.uploadProof,
        FormData.fromMap(
            {'ProofOfIdentity': MultipartFile.fromFileSync(nationalId.path)}),
      );
      if (response.statusCode == 200) {
        return response.data['proofOfIdentityUrl'];
      }
      return response.data.toString();
    } catch (e) {
      return "CHECK YOUR NETWORK";
    }
  }

  Future<Either<Exception, String>> verifyCode({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          "resetCode": code,
          "email": email,
          "newPassword": password,
        },
        path: EndPoints.verifyResetCode,
      );
      await login(
          email: email, password: password, loginWithFBOrGG: false);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Owner>> getProfile(int id) async {
    try {
      Response response = await DioHelper.getData(
        path: "/${ConstantsManager.userId == id ? "Owner" : "Player"}/$id",
      );
      Owner owner = Owner.fromJson(response.data);
      if (ConstantsManager.userId == id) {
        ConstantsManager.appUser = owner;
      }
      return Right(owner);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<AppFeedBack>>> geFeedBacks(int id) async {
    try {
      Response response = await DioHelper.getData(
        path: "${EndPoints.getFeedbacks}$id",
      );
      List<AppFeedBack> feedBacks = [];
      for (var category in response.data["reviews"]) {
        feedBacks.add(AppFeedBack.fromJson(category));
      }
      return Right(feedBacks);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
