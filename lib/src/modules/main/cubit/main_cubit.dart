import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/sport.dart';

import 'package:hawi_hub_owner/src/modules/main/data/services/main_services.dart';
import 'package:hawi_hub_owner/src/modules/main/data/services/notification_services.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/pages/home_page.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/pages/more_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/all_requests_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/places_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/upcoming_reservations.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  static MainCubit cubit = MainCubit();

  static MainCubit get() => cubit;
  MainServices mainServices = MainServices();

  MainCubit() : super(MainInitial());
  List<Widget> pages = [
    const HomePage(),
    const AllPlacesPage(),
    const AllRequestsPage(),
    UpcomingReservationsPage(),
    const MorePage(),
  ];
  int currentIndex = 0;
  List<String> bannerList = [];
  List<Sport> sportsList = [];
  List<AppNotification> notifications = [];

  void changePage(int index) {
    currentIndex = index;
    emit(ChangePage(index));
  }

  Future<void> getBanner() async {
    emit(GetBannersLoading());
    var result = await mainServices.getBanners();
    result.fold((l) {
      // ExceptionManager(l).translatedMessage();
      emit(GetBannersError(l));
    }, (r) {
      bannerList = r;
      emit(GetBannersSuccess(r));
    });
  }

  Future<void> changeLanguage(int index) async {
    emit(ChangeLocaleLoading());
    await LocalizationManager.setLocale(index);
    emit(ChangeLocaleState(index));
  }

  Future<void> getSports() async {
    emit(GetSportsLoading());
    var result = await mainServices.getSports();
    result.fold((l) {
      emit(GetSportsError(l));
    }, (r) {
      sportsList = r;
      emit(GetSportsSuccess(r));
    });
  }

  getNotifications() async {
    emit(GetNotificationsLoading());
    NotificationServices notificationServices = NotificationServices();
    var result = await notificationServices.getNotifications();
    result.fold((l) {
      emit(GetNotificationsError(l));
    }, (r) {
      notifications = r;
      emit(GetNotificationsSuccess(r));
    });
  }

  void markNotificationAsRead(int i) {
    NotificationServices().markAsRead(i);
  }
}
