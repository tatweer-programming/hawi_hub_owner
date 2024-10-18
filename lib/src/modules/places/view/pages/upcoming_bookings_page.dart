import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/app_booking_shimmer.dart';
import 'package:sizer/sizer.dart';

class UpComingOnlineBookingsPage extends StatelessWidget {
  const UpComingOnlineBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit = PlaceCubit.get();
    return BlocListener<PlaceCubit, PlaceState>(
      bloc: PlaceCubit.get(),
      listener: (context, state) {
        if (state is PlaceError) {
          errorToast(
              msg: ExceptionManager(state.exception).translatedMessage());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<PlaceCubit, PlaceState>(
              bloc: placeCubit,
              builder: (context, state) {
                return (state is GetReservationsLoading)
                    ? const VerticalAppBookingsShimmer()
                    : placeCubit.futureBookings.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Center(
                                child: SubTitle(S.of(context).noBookings)),
                          )
                        : Column(
                            children: [
                              SubTitle(S.of(context).appBookings),
                              ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => BookingItem(
                                      bookingRequest:
                                          placeCubit.futureBookings[index]),
                                  separatorBuilder: (itemContext, index) =>
                                      const Divider(),
                                  itemCount: placeCubit.futureBookings.length),
                            ],
                          );
              })
        ],
      ),
    );
  }
}
