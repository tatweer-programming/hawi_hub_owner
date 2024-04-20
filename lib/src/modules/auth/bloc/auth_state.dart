part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

// register player
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}
// Login google
//
// class LoginWithGoogleLoadingState extends AuthState {}
//
// class LoginWithGoogleSuccessState extends AuthState {}
//
// class LoginWithGoogleErrorState extends AuthState {
//   final String error;
//
//   LoginWithGoogleErrorState(this.error);
// }

// verifyCode

class VerifyCodeLoadingState extends AuthState {}

class VerifyCodeSuccessState extends AuthState {}

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

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
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

class ChangePasswordVisibilityState extends AuthState {
  final bool visible;

  ChangePasswordVisibilityState(this.visible);
}

class AddProfilePictureSuccessState extends AuthState {
  final File profilePictureFile;

  AddProfilePictureSuccessState({required this.profilePictureFile});
}

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
