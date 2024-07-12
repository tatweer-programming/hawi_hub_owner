import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/auth_owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/repositories/auth_repository.dart';
import 'package:hawi_hub_owner/src/modules/main/data/services/notification_services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../main/cubit/main_cubit.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc instance = AuthBloc(AuthInitial());

  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  final AuthRepository _repository = AuthRepository();

  // time
  Timer? timeToResendCodeTimer;

  AuthBloc(AuthState state) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterPlayerEvent) {
        emit(RegisterLoadingState());
        var result =
            await _repository.registerPlayer(authOwner: event.authOwner);
        result.fold((l) => emit(RegisterErrorState(l)), (r) async {
          emit(RegisterSuccessState(value: r));
          await NotificationServices().subscribeToTopic();
        });
      } else if (event is LoginPlayerEvent) {
        emit(LoginLoadingState());
        await _repository
            .loginPlayer(
                email: event.email,
                password: event.password,
                loginWithFBOrGG: false)
            .then((value) async {
          if (value == "Account LogedIn Successfully") {
            emit(LoginSuccessState(value));
            await NotificationServices().subscribeToTopic();
          } else {
            emit(LoginErrorState(value));
          }
        });
      } else if (event is VerifyCodeEvent) {
        emit(VerifyCodeLoadingState());
        var result = await _repository.verifyCode(
          code: event.code,
          email: event.email,
          password: event.password,
        );
        result.fold((l) => emit(VerifyCodeErrorState(l)),
            (r) => emit(VerifyCodeSuccessState(value: r)));
      } else if (event is ResetPasswordEvent) {
        add(StartResendCodeTimerEvent(120));
        emit(ResetPasswordLoadingState());
        await _repository.resetPassword(event.email).then((value) {
          if (value == "Reset code sent successfully to ${event.email}.") {
            String msg =
                "${S.of(event.context).resetCodeSentSuccessfully} ${event.email}.";
            emit(ResetPasswordSuccessState(msg));
          } else {
            emit(ResetPasswordErrorState(value));
          }
        });
      } else if (event is LoginWithGoogleEvent) {
        emit(LoginLoadingState());
        var result = await _repository.loginWithGoogle();
        result.fold((l) {
          emit(LoginErrorState(l));
        }, (r) {
          if (r == "Account LogedIn Successfully") {
            emit(LoginSuccessState(r));
          } else {
            emit(LoginErrorState(r));
          }
        });
      } else if (event is LoginWithFacebookEvent) {
        emit(LoginLoadingState());
        var result = await _repository.loginWithFacebook();
        result.fold((l) {
          emit(LoginErrorState(l));
        }, (r) {
          if (r == "Account LogedIn Successfully") {
            emit(LoginSuccessState(r));
          } else {
            emit(LoginErrorState(r));
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
        result.fold((l) {
          ChangePasswordErrorState(l);
        }, (r) {
          emit(ChangePasswordSuccessState(r));
        });
      } else if (event is AddImageEvent) {
        await _captureAndSaveGalleryImage().then((imagePicked) {
          if (imagePicked != null) {
            emit(AddImageSuccessState(imagePicked: imagePicked!));
          }
        });
      } else if (event is DeleteImageEvent) {
        emit(DeleteImageState());
      } else if (event is UploadNationalIdEvent) {
        emit(UploadNationalIdLoadingState());
        var res = await _repository.uploadNationalId(event.nationalId);
        res.fold((l) {
          emit(UploadNationalIdErrorState(l));
        }, (r) {
          emit(UploadNationalIdSuccessState(r));
        });
      } else if (event is OpenPdfEvent) {
        File pdfFile = await _loadPdfFromAssets();
        OpenFile.open(pdfFile.path);
        emit(OpenPdfState());
      } else if (event is UpdateProfilePictureEvent) {
        add(AddImageEvent());
        if (state is AddImageSuccessState) {
          await _repository.changeProfileImage(event.profileImage);
        }
      } else if (event is GetProfileEvent) {
        emit(GetProfileLoadingState());
        var res = await _repository.getProfile(event.id);
        res.fold((l) {
          emit(GetProfileErrorState(l));
        }, (owner) {
          emit(GetProfileSuccessState(owner));
        });
      } else if (event is AcceptConfirmTermsEvent) {
        if (event.accept) {
          emit(AcceptConfirmTermsState(false));
        } else {
          emit(AcceptConfirmTermsState(true));
        }
      } else if (event is KeepMeLoggedInEvent) {
        if (event.keepMeLoggedIn) {
          emit(KeepMeLoggedInState(false));
        } else {
          emit(KeepMeLoggedInState(true));
        }
      } else if (event is ChangePasswordVisibilityEvent) {
        if (event.visible) {
          emit(ChangePasswordVisibilityState(false));
        } else {
          emit(ChangePasswordVisibilityState(true));
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
    timeToResendCode = 120;
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

Future<File> _loadPdfFromAssets() async {
  final byteData = await rootBundle.load('assets/pdfs/Requirements.pdf');
  final file = File('${(await getTemporaryDirectory()).path}/Requirements.pdf');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file;
}

Future _clearUserData() async {
  ConstantsManager.userId = null;
  ConstantsManager.appUser = null;
  ConstantsManager.connectionId = null;
  ConstantsManager.connectionToken = null;
  MainCubit.get().currentIndex = 0;
  await CacheHelper.removeData(key: "userId");
}

Future<File?> _captureAndSaveGalleryImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowMultiple: false,
  );
  if (result != null) {
    final image = File(result.files.single.path!);
    return image;
  } else {
    return null;
  }
}
