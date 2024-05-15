import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/auth_owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/repositories/auth_repository.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/sport.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models/owner.dart';
import '../data/models/sport.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc instance = AuthBloc(AuthInitial());

  static AuthBloc get(BuildContext context) => BlocProvider.of<AuthBloc>(context);

  final AuthRepository _repository = AuthRepository();
  Owner? owner;

  // time
  Timer? timeToResendCodeTimer;

  AuthBloc(AuthState state) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterPlayerEvent) {
        emit(RegisterLoadingState());
        await _repository.registerPlayer(authOwner: event.authOwner).then((value) {
          if (value == "Account Created Successfully") {
            emit(RegisterSuccessState(value: value));
          } else {
            emit(RegisterErrorState(value));
          }
        });
      } else if (event is LoginPlayerEvent) {
        emit(LoginLoadingState());
        await _repository
            .loginPlayer(email: event.email, password: event.password, loginWithFBOrGG: false)
            .then((value) {
          if (value == "Account LogedIn Successfully") {
            emit(LoginSuccessState(value));
          } else {
            emit(LoginErrorState(value));
          }
        });
      } else if (event is VerifyCodeEvent) {
        add(StartResendCodeTimerEvent(60));
        emit(VerifyCodeLoadingState());
        await _repository.verifyCode(event.email).then((value) {
          if (value == "Code Sent") {
            emit(VerifyCodeSuccessState());
          } else {
            emit(VerifyCodeErrorState(value));
          }
        });
      } else if (event is LoginWithGoogleEvent) {
        emit(LoginLoadingState());
        var result = await _repository.loginWithGoogle();
        result.fold((l) {
          emit(LoginErrorState(l));
        }, (r) {
          if (r) {
            emit(LoginSuccessState("Account LogedIn Successfully"));
          } else {
            emit(LoginErrorState("Something went wrong"));
          }
        });
      } else if (event is LoginWithFacebookEvent) {
        emit(LoginLoadingState());
        var result = await _repository.loginWithFacebook();
        result.fold((l) {
          emit(LoginErrorState(l));
        }, (r) {
          if (r) {
            emit(LoginSuccessState("Account LogedIn Successfully"));
          } else {
            emit(LoginErrorState("Something went wrong"));
          }
        });
      } else if (event is SignupWithGoogleEvent) {
        emit(SignupWithGoogleLoadingState());
        var result = await _repository.signupWithGoogle();
        result.fold((l) {
          emit(SignupWithGoogleErrorState(l));
        }, (r) {
          if (r != null) {
            emit(SignupWithGoogleSuccessState(r));
          } else {
            emit(SignupWithGoogleErrorState("Something went wrong"));
          }
        });
      } else if (event is SignupWithFacebookEvent) {
        emit(SignupWithFacebookLoadingState());
        var result = await _repository.signupWithFacebook();
        result.fold((l) {
          emit(SignupWithFacebookErrorState(l));
        }, (r) {
          if (r != null) {
            emit(SignupWithFacebookSuccessState(r));
          } else {
            emit(SignupWithFacebookErrorState("Something went wrong"));
          }
        });
      } else if (event is LogoutEvent) {
        emit(LogoutLoadingState());
        _clearUserData();
        emit(LogoutSuccessState());
      } else if (event is ChangePasswordEvent) {
        var result = await _repository.changePassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );
        if (result == "Password Changed Successfully") {
          emit(ChangePasswordSuccessState(result));
        } else {
          emit(ChangePasswordErrorState("Something went wrong"));
        }
      } else if (event is ResetPasswordEvent) {
        emit(ResetPasswordLoadingState());
        await _repository
            .resetPassword(
          code: event.code,
          email: event.email,
          password: event.password,
        )
            .then((value) {
          if (value == "Password Reset Successful") {
            emit(ResetPasswordSuccessState(value));
          } else {
            emit(ResetPasswordErrorState(value));
          }
        });
      } else if (event is AddImageEvent) {
        await _captureAndSaveGalleryImage().then((imagePicked) {
          emit(AddImageSuccessState(imagePicked: imagePicked!));
        });
      } else if (event is DeleteImageEvent) {
        emit(DeleteImageState());
      } else if (event is UploadNationalIdEvent) {
        await _repository.uploadNationalId(event.nationalId);
      } else if (event is UpdateProfilePictureEvent) {
        add(AddImageEvent());
        if (state is AddImageSuccessState) {
          await _repository.changeProfileImage(event.profileImage);
        }
      } else if (event is GetProfileEvent) {
        emit(GetMyProfileLoadingState());
        var res = await _repository.getProfile(event.id);
        res.fold((l) {
          emit(GetMyProfileErrorState(l));
        }, (r) {
          owner = r;
          print(owner);
          emit(GetMyProfileSuccessState());
        });
      } else if (event is AcceptConfirmTermsEvent) {
        if (event.accept) {
          emit(AcceptConfirmTermsState(false));
        } else {
          emit(AcceptConfirmTermsState(true));
        }
      } else if (event is ChangePasswordVisibilityEvent) {
        if (event.visible) {
          emit(ChangePasswordVisibilityState(false));
        } else {
          emit(ChangePasswordVisibilityState(true));
        }
      } else if (event is SelectSportEvent) {
        List<Sport> selectedSports = event.sports;
        if (event.sports.contains(event.sport)) {
          selectedSports.remove(event.sport);
          emit(SelectSportState(sports: selectedSports));
        } else {
          selectedSports.add(event.sport);
          emit(SelectSportState(sports: selectedSports));
        }
      } else if (event is StartResendCodeTimerEvent) {
        _startResendCodeTimer(event.timeToResendCode);
      } else if (event is ResetCodeTimerEvent) {
        timeToResendCodeTimer?.cancel();
        emit(ResetCodeTimerState(time: 0));
      } else if (event is PlaySoundEvent) {
        final audioPlayer = AudioPlayer();
        await audioPlayer.play(AssetSource(event.sound));
        emit(PlaySoundState());
      }
    });
  }

  void _startResendCodeTimer(int timeToResendCode) {
    timeToResendCode = 60;
    timeToResendCodeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeToResendCode > 0) {
        timeToResendCode--;
        emit(ChangeTimeToResendCodeState(time: timeToResendCode));
      } else {
        timeToResendCodeTimer?.cancel();
        timeToResendCode = 0;
        emit(ChangeTimeToResendCodeState(time: 0));
      }
    });
  }
}

Future _clearUserData() async {
  ConstantsManager.userId = null;
  await CacheHelper.removeData(key: "id");
}

Future<File?> _captureAndSaveGalleryImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final image = File(pickedFile.path);
    return image;
  } else {
    return null;
  }
}
