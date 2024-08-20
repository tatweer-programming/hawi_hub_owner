import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/offline_bookings_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/upcoming_bookings_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/app_booking_shimmer.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/request_shimmers.dart';
import 'package:sizer/sizer.dart';

class FutureBookingsScreen extends StatelessWidget {
  const FutureBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      UpComingOnlineBookingsPage(),
      UpcomingOfflineBookingsPage(),
    ];
    PlaceCubit placeCubit = PlaceCubit.get()
      ..getAppBookings()
      ..getOfflineBookings();
    return RefreshIndicator(
      onRefresh: () async {
        placeCubit.getOfflineBookings(isRefresh: true);
        placeCubit.getAppBookings(isRefresh: true);
      },
      notificationPredicate: (list) => true,
      child: Scaffold(
        bottomNavigationBar: _buildNavBar(),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                height: 33.h,
                opacity: .15,
                actions: [],
                backgroundImage: "assets/images/app_bar_backgrounds/1.webp",
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: SizedBox(
                    height: 7.h,
                    child: Text(
                      S.of(context).futureBookings,
                      style: TextStyleManager.getAppBarTextStyle(),
                    ),
                  ),
                ),
              ),
              BlocBuilder<PlaceCubit, PlaceState>(
                buildWhen: (previous, current) =>
                    current is ChangeUpcomingPageState,
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.all(5.w),
                    child: ConnectionWidget(
                        child: pages[placeCubit.upcomingBookingPageIndex],
                        onRetry: retryConnecting),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void retryConnecting() async {
    PlaceCubit.get().getAppBookings();
    PlaceCubit.get().getOfflineBookings();
  }

  Widget _buildNavBar() {
    PlaceCubit placeCubit = PlaceCubit.get();
    return SizedBox(
      height: 7.5.h,
      width: double.infinity,
      child: Stack(children: [
        Center(
          child: Container(
            color: ColorManager.primary,
            height: 2.5.h,
            width: double.infinity,
          ),
        ),
        Positioned.fill(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: BlocBuilder<PlaceCubit, PlaceState>(
                    bloc: placeCubit,
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: placeCubit.upcomingBookingPageIndex == 0
                              ? ColorManager.primary
                              : Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(360),
                            radius: 360,
                            onTap: () {
                              placeCubit.changeUpcomingSelectedPage(0);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 1.h),
                                Expanded(
                                    child: Icon(Icons.book_online,
                                        color: Colors.white)),
                                Text(S.of(context).appBookings,
                                    style: TextStyle(
                                        fontSize: 9.5.sp,
                                        color: 0 == 0
                                            ? Colors.white
                                            : Colors.grey[600])),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: BlocBuilder<PlaceCubit, PlaceState>(
                    bloc: placeCubit,
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: placeCubit.upcomingBookingPageIndex == 1
                              ? ColorManager.primary
                              : Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(360),
                            radius: 360,
                            onTap: () {
                              placeCubit.changeUpcomingSelectedPage(1);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 1.h),
                                Expanded(
                                    child: Icon(Icons.wifi_off_outlined,
                                        color: Colors.white)),
                                Text(S.of(context).offlineBookings,
                                    style: TextStyle(
                                        fontSize: 9.5.sp,
                                        color: 0 == 0
                                            ? Colors.white
                                            : Colors.grey[600])),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
