import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/sport.dart';

import 'package:hawi_hub_owner/src/modules/main/data/services/main_services.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/pages/home_page.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/pages/more_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/all_requests_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/places_page.dart';

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
    const MorePage(),
  ];
  int currentIndex = 0;
  List<String> bannerList = [];
  List<Sport> sportsList = [];
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
}
