import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/offline_bookings_page.dart';
import 'package:hawi_hub_owner/src/modules/places/view/pages/upcoming_bookings_page.dart';
import 'package:sizer/sizer.dart';

class UpcomingReservationsPage extends StatelessWidget {
  const UpcomingReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit = PlaceCubit.get();
    return RefreshIndicator(
      onRefresh: () async {
        Future.wait([
          placeCubit.getOfflineBookings(isRefresh: true),
          placeCubit.getAppBookings(isRefresh: true)
        ]);
      },
      child: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultAppBar(),
                SizedBox(height: 3.h),
                const UpComingTabBar(),
                SizedBox(height: 3.h),
                BlocBuilder<PlaceCubit, PlaceState>(
                    bloc: placeCubit,
                    builder: (context, state) {
                      return _pages[placeCubit.upcomingBookingPageIndex];
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> _pages = const [
    UpcomingOfflineBookingsPage(),
    UpComingOnlineBookingsPage(),
  ];
}

class UpComingTabBar extends StatelessWidget {
  const UpComingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit mainCubit = PlaceCubit.get();
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: ColorManager.grey2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<PlaceCubit, PlaceState>(
        bloc: mainCubit,
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: mainCubit.upcomingBookingPageIndex == 0
                        ? ColorManager.primary
                        : ColorManager.grey2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      mainCubit.changeUpcomingSelectedPage(0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          S.of(context).offlineBookings,
                          style: const TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: mainCubit.upcomingBookingPageIndex == 1
                        ? ColorManager.primary
                        : ColorManager.grey2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      mainCubit.changeUpcomingSelectedPage(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          S.of(context).futureBookings,
                          style: const TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
