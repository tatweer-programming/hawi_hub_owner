part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();
}

final class MainInitial extends MainState {
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

class GetBannersError extends MainState {
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

class GetSportsError extends MainState {
  @override
  List<Object> get props => [];
}
