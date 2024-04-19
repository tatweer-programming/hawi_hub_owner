import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/random_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/sport.dart';
import '../../../../core/apis/dio_helper.dart';

class AuthService {
  Future<String> registerPlayer({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'user_name': userName,
          'pass': password,
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

  Future<String> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        print(googleUser.displayName);
        // await DioHelper.postData(
        //   data: {
        //     'mail': googleUser.email,
        //     'user_name': googleUser.displayName,
        //     "image": googleUser.photoUrl,
        //     'pass': RandomManager.generateRandomString(),
        //   },
        //   path: EndPoints.register,
        // ).then((value) async {
        //   ConstantsManager.userToken = googleUser.id;
        //   await CacheHelper.saveData(key: 'token', value: googleUser.id);
        // });
        return "Login Successfully";
      }
      return "Login Failed";
    } catch (e) {
      return "Invalid email or password";
    }
  }

  Future<String> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      Map<String, dynamic>? userData;
      if (result.status == LoginStatus.success) {
        userData = await FacebookAuth.instance.getUserData();
      }
      if (result.status == LoginStatus.success && userData != null) {
        await DioHelper.postData(
          data: {
            'mail': userData["email"],
            'user_name': userData["name"],
            "image": userData["picture"]["data"]["url"],
            'pass': RandomManager.generateRandomString(),
          },
          path: EndPoints.register,
        ).then((value) async {
          ConstantsManager.userToken = userData!["id"];
          await CacheHelper.saveData(key: 'token', value: userData["id"]);
        });
        return "Login Successfully";
      }
      return "Login Failed";
    } catch (e) {
      return "Invalid email or password";
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
