part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterPlayerEvent extends AuthEvent {
  final String email;
  final String userName;
  final String password;

  RegisterPlayerEvent(
      {required this.email, required this.userName, required this.password});
}

class LoginPlayerEvent extends AuthEvent {
  final String email;
  final String password;

  LoginPlayerEvent({required this.email, required this.password});
}

class AddProfilePictureEvent extends AuthEvent {}

class GetSportsEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class VerifyCodeEvent extends AuthEvent {
  final String email;

  VerifyCodeEvent(this.email);
}

class LoginWithGoogleEvent extends AuthEvent {}

class LoginWithFacebookEvent extends AuthEvent {}

class GetProfileEvent extends AuthEvent {
  final int id;

  GetProfileEvent(this.id);
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String code;
  final String password;

  ResetPasswordEvent(
      {required this.email, required this.code, required this.password});
}

class StartResendCodeTimerEvent extends AuthEvent {
  final int timeToResendCode;

  StartResendCodeTimerEvent(this.timeToResendCode);
}

class ResetCodeTimerEvent extends AuthEvent {
  final int timeToResendCode;

  ResetCodeTimerEvent(this.timeToResendCode);
}

class SelectSportEvent extends AuthEvent {
  final List<Sport> sports;
  final Sport sport;

  SelectSportEvent({required this.sports, required this.sport});
}

class AcceptConfirmTermsEvent extends AuthEvent {
  final bool accept;

  AcceptConfirmTermsEvent(this.accept);
}

class ChangePasswordVisibilityEvent extends AuthEvent {
  final bool visible;

  ChangePasswordVisibilityEvent(this.visible);
}

class PlaySoundEvent extends AuthEvent {
  final String sound;

  PlaySoundEvent(this.sound);
}
