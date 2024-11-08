part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();
}

final class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class MainError extends MainState {
  final Exception exception;

  const MainError(this.exception);

  @override
  List<Object> get props => [];
}

class ChangePage extends MainState {
  final int index;

  const ChangePage(this.index);

  @override
  List<Object?> get props => [index];
}

class GetBannersLoading extends MainState {
  @override
  List<Object> get props => [];
}

class GetBannersSuccess extends MainState {
  final List<String> banners;

  const GetBannersSuccess(this.banners);

  @override
  List<Object> get props => [];
}

class ChangeLocaleState extends MainState {
  final int index;

  const ChangeLocaleState(this.index);

  @override
  List<Object> get props => [index];
}
class ChangeLocaleLoading extends MainState {

  @override
  List<Object> get props => [];
}class ShowDialogState extends MainState {

  @override
  List<Object> get props => [];
}

class GetBannersError extends MainError {
  const GetBannersError(super.exception);

  @override
  List<Object> get props => [];
}

class GetSportsLoading extends MainState {
  @override
  List<Object> get props => [];
}

class GetSportsSuccess extends MainState {
  final List<Sport> sports;

  const GetSportsSuccess(this.sports);

  @override
  List<Object> get props => [];
}

class GetSportsError extends MainError {
  const GetSportsError(super.exception);

  @override
  List<Object> get props => [];
}

class GetNotificationsLoading extends MainState {
  @override
  List<Object> get props => [];
}

class GetNotificationsSuccess extends MainState {
  final List<AppNotification> notifications;

  const GetNotificationsSuccess(this.notifications);

  @override
  List<Object> get props => [];
}

class GetNotificationsError extends MainError {
  const GetNotificationsError(super.exception);

  @override
  List<Object> get props => [];
}
