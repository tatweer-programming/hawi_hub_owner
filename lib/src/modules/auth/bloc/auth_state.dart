part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

// register player
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String value;

  RegisterSuccessState({required this.value});
}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}
// Signup google

class SignupWithGoogleLoadingState extends AuthState {}

class SignupWithGoogleSuccessState extends AuthState {
  final AuthOwner authOwner;

  SignupWithGoogleSuccessState(this.authOwner);
}

class SignupWithGoogleErrorState extends AuthState {
  final String error;

  SignupWithGoogleErrorState(this.error);
} // Signup facebook

class SignupWithFacebookLoadingState extends AuthState {}

class SignupWithFacebookSuccessState extends AuthState {
  final AuthOwner authOwner;

  SignupWithFacebookSuccessState(this.authOwner);
}

class SignupWithFacebookErrorState extends AuthState {
  final String error;

  SignupWithFacebookErrorState(this.error);
}

// verifyCode

class VerifyCodeLoadingState extends AuthState {}

class VerifyCodeSuccessState extends AuthState {
  final String value;

  VerifyCodeSuccessState({required this.value});
}

class VerifyCodeErrorState extends AuthState {
  final String error;

  VerifyCodeErrorState(this.error);
}

// get sports
class GetSportsLoadingState extends AuthState {}

class GetSportsSuccessState extends AuthState {
  final List<Sport> sports;

  GetSportsSuccessState(this.sports);
}

class GetSportsErrorState extends AuthState {
  final String error;

  GetSportsErrorState(this.error);
}

// get My Profile
class GetMyProfileLoadingState extends AuthState {}

class GetMyProfileSuccessState extends AuthState {}

class GetMyProfileErrorState extends AuthState {
  final String error;

  GetMyProfileErrorState(this.error);
}

// login player
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String value;

  LoginSuccessState(this.value);
}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}
// Change pass

class ChangePasswordErrorState extends AuthState {
  final String error;

  ChangePasswordErrorState(this.error);
}

class ChangePasswordSuccessState extends AuthState {
  final String value;

  ChangePasswordSuccessState(this.value);
}

// logout player
class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

// Reset Password
class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {
  final String message;

  ResetPasswordSuccessState(this.message);
}

class ResetPasswordErrorState extends AuthState {
  final String error;

  ResetPasswordErrorState(this.error);
}

class AcceptConfirmTermsState extends AuthState {
  final bool accept;

  AcceptConfirmTermsState(this.accept);
}

class UpdateProfileLoadingState extends AuthState {}

class ChangePasswordVisibilityState extends AuthState {
  final bool visible;

  ChangePasswordVisibilityState(this.visible);
}

class AddImageSuccessState extends AuthState {
  final File? imagePicked;

  AddImageSuccessState({required this.imagePicked});
}

class UploadNationalIdSuccessState extends AuthState {
  final String msg;

  UploadNationalIdSuccessState(this.msg);
}

class UploadNationalIdLoadingState extends AuthState {}

class UploadNationalIdErrorState extends AuthState {
  final String error;

  UploadNationalIdErrorState(this.error);
}

class DeleteImageState extends AuthState {}

class SelectSportState extends AuthState {
  final List<Sport> sports;

  SelectSportState({required this.sports});
}

class ChangeTimeToResendCodeState extends AuthState {
  final int time;

  ChangeTimeToResendCodeState({required this.time});
}

class ResetCodeTimerState extends AuthState {
  final int time;

  ResetCodeTimerState({required this.time});
}

class PlaySoundState extends AuthState {}
