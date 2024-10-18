import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/image_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../generated/l10n.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class AllPlacesPage extends StatelessWidget {
  const AllPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();

    return ConnectionWidget(
        onRetry: () {
          cubit.getPlaces();
        },
        child: BlocListener<PlaceCubit, PlaceState>(
          listener: (context, state) {
            if (state is PlaceError) {
              errorToast(
                  msg: ExceptionManager(state.exception).translatedMessage());
            }
          },
          child: BlocBuilder<PlaceCubit, PlaceState>(builder: (context, state) {
            if (state is GetPlacesLoading) {
              return const VerticalPlacesShimmer();
            }
            return SingleChildScrollView(
              child: Stack(
                children: [
                  ImageAppBar(
                    title: S.of(context).places,
                    imagePath: "assets/images/app_bar_backgrounds/play.jpg",
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.w),
                              child: Skeletonizer(
                                justifyMultiLineText: true,
                                ignorePointers: false,
                                ignoreContainers: false,
                                effect: const PulseEffect(),
                                enabled: state is GetPlacesLoading,
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 2.h,
                                  ),
                                  itemBuilder: (context, index) => state
                                          is GetPlacesLoading
                                      ? PlaceItem(place: dummyPlaces[index])
                                      : PlaceItem(
                                          place:
                                              PlaceCubit.get().places[index]),
                                  itemCount: state is GetPlacesLoading
                                      ? dummyPlaces.length
                                      : PlaceCubit.get().places.length,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ));
  }
}

List<Place> dummyPlaces = [
  Place(
    id: 1,
    name: "ملعب القاهرة الدولي",
    address: "شارع 26 يوليو، قصر النيل، القاهرة",
    workingHours: [],
    //location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    description: "ملعب متعدد الاستخدامات، يستضيف المباريات الدولية والمحلية.",
    sport: 1,
    price: 500.0,
    ownerId: 1,
    images: ["", ""],
    totalGames: 100,
    totalRatings: 250,
    rating: 4.5,
    feedbacks: [],

    citId: 1,
    approvalStatus: 1,
    availableGender: Gender.both,
    deposit: 100,
    isShared: false,
  ),
  Place(
    id: 2,
    name: "استاد برج العرب",
    address: "الكيلو 21، طريق مصر إسكندرية الصحراوي",
    workingHours: [],
    //location: PlaceLocation(longitude: "29.8834", latitude: "31.1862"),
    location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    description:
        "أحد أكبر الملاعب في مصر، ويستضيف العديد من الفعاليات الرياضية.",
    sport: 1,
    price: 600.0,
    ownerId: 2,
    images: ["", ""],
    totalGames: 80,
    totalRatings: 150,
    rating: 4.7,
    feedbacks: [],

    citId: 2,
    approvalStatus: 1,
    availableGender: Gender.both,
    deposit: 150,
    isShared: true,
  ),
  Place(
    id: 3,
    name: "استاد القاهرة",
    address: "شارع 26 يوليو، قصر النيل، القاهرة",
    workingHours: [],
    //location: PlaceLocation(longitude: "31.2357", latitude: "30.0483"),
    location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    description: "يستضيف المباريات النهائية للكثير من البطولات.",
    sport: 1,
    price: 700.0,
    ownerId: 3,
    images: ["", ""],
    totalGames: 90,
    totalRatings: 300,
    rating: 4.8,
    feedbacks: [],

    citId: 1,
    approvalStatus: 1,
    availableGender: Gender.both,
    deposit: 200,
    isShared: false,
  ),
];
