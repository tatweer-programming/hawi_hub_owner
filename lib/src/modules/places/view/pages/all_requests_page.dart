import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/image_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/request_shimmers.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/connectivity.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class AllRequestsPage extends StatelessWidget {
  const AllRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectionWidget(
      onRetry: retryConnecting,
      child: BlocListener<PlaceCubit, PlaceState>(
        bloc: PlaceCubit.get(),
        listener: (context, state) {
          if (state is PlaceError) {
            errorToast(
                msg: ExceptionManager(state.exception).translatedMessage());
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              ImageAppBar(
                title: S.of(context).requests,
                imagePath: "assets/images/app_bar_backgrounds/stadium.jpeg",
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
                        BlocBuilder<PlaceCubit, PlaceState>(
                            bloc: PlaceCubit.get(),
                            builder: (context, state) {
                              return (state is GetBookingRequestsLoading)
                                  ? const VerticalRequestsShimmer()
                                  : PlaceCubit.get().bookingRequests.isEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 20.h),
                                          child: Center(
                                              child: SubTitle(
                                                  S.of(context).noRequests)),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.h, horizontal: 5.w),
                                          child: ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  BookingRequestWidget(
                                                      bookingRequest: PlaceCubit
                                                                  .get()
                                                              .bookingRequests[
                                                          index]),
                                              separatorBuilder:
                                                  (itemContext, index) =>
                                                      const Divider(),
                                              itemCount: PlaceCubit.get()
                                                  .bookingRequests
                                                  .length),
                                        );
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void retryConnecting() {
    PlaceCubit.get().getBookingRequests();
  }
}
