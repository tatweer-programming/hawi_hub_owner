import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/services/location_services.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/banners.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/banner_shimmer.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/request_shimmers.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get()..getBanner();
    PlaceCubit placeCubit = PlaceCubit.get()
      ..getPlaces()
      ..getBookingRequests();
    LocationServices.determinePosition();
    return BlocConsumer<PlaceCubit, PlaceState>(
      listener: (context, state) {
        if (state is PlaceError) {
          errorToast(
              msg: ExceptionManager(state.exception).translatedMessage());
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultAppBar(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              child: ConnectionWidget(
                  onRetry: retryConnecting,
                  child: Column(children: [
                    const CustomCarousel(),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TitleText(S.of(context).requests,
                                isBold: true)),
                        TextButton(
                            onPressed: () {
                              mainCubit.changePage(2);
                            },
                            child: Row(
                              children: [
                                Text(S.of(context).viewAll,
                                    style: TextStyleManager
                                        .getGoldenRegularStyle()),
                                const Icon(Icons.arrow_forward,
                                    color: ColorManager.golden)
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 21.h,
                      child: BlocBuilder<PlaceCubit, PlaceState>(
                          bloc: placeCubit,
                          builder: (context, state) {
                            return state is GetBookingRequestsLoading ||
                                    placeCubit.isBookingRequestsLoading
                                ? const HorizontalRequestsShimmer()
                                : placeCubit.bookingRequests.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                              child: const Icon(
                                                Icons.search_off_outlined,
                                                color: ColorManager.black,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            TitleText(S.of(context).noRequests),
                                          ],
                                        ),
                                      )
                                    : ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            BookingRequestWidget(
                                                bookingRequest: placeCubit
                                                    .bookingRequests[index]),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                        itemCount: placeCubit
                                                    .bookingRequests.length <
                                                3
                                            ? placeCubit.bookingRequests.length
                                            : 3);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TitleText(S.of(context).yourPlaces,
                                isBold: true)),
                        TextButton(
                            onPressed: () {
                              mainCubit.changePage(1);
                            },
                            child: Row(
                              children: [
                                Text(S.of(context).viewAll,
                                    style: TextStyleManager
                                        .getGoldenRegularStyle()),
                                const Icon(Icons.arrow_forward,
                                    color: ColorManager.golden)
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 45.h,
                      child: BlocBuilder<PlaceCubit, PlaceState>(
                          bloc: placeCubit,
                          builder: (context, state) {
                            return state is GetPlacesLoading ||
                                    placeCubit.isPlacesLoading
                                ? const HorizontalPlacesShimmer()
                                : placeCubit.places.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                              child: const Icon(
                                                Icons.search_off_outlined,
                                                color: ColorManager.black,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            TitleText(S.of(context).noPlaces),
                                          ],
                                        ),
                                      )
                                    : ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            PlaceItem(
                                                place:
                                                    placeCubit.places[index]),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                        itemCount: placeCubit.places.length < 3
                                            ? placeCubit.places.length
                                            : 3);
                          }),
                    ),
                  ])),
            ),
          ],
        );
      },
    );
  }

  void retryConnecting() async {
    MainCubit.get().getBanner();
    MainCubit.get().getSports();
    PlaceCubit.get().getPlaces();
    PlaceCubit.get().getBookingRequests();
  }
}

// Place place = Place(
//   latitudes: "",
//   longitudes: "",
//   totalGames: 122,
//   totalRatings: 90,
//   rating: 3.5,
//   address:
//       "place address place address place address place address place address place address place address place address",
//   ownerId: 1,
//   name: "Place name",
//   description:
//       "place place place place place place place place place place place place place place place place place place place place place place place place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description ",
//   images: const [
//     "https://www.sofistadium.com/assets/img/SoFiStadium_bowl-9f3e09bf67.jpg",
//     "https://www.accoes.com/wp-content/uploads/2022/08/IMG_5382-scaled.jpg",
//     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9E2ITnbivkVxMi2refJT2OUZb4SaCOZJJeIvMjUwgWCiHoFLnKUOU7m1a4wz1Lp9_Hzo&usqp=CAU",
//   ],
//   id: 1,
//   ownerImageUrl: '',
//   ownerName: 'owner name',
//   sport: 'Football',
//   price: 0,
//   minimumHours: 0,
//   completedDays: const [],
//   feedbacks: const [],
// );
