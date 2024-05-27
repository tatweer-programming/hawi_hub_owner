import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/extentions/date_extention.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';

class RequestScreen extends StatelessWidget {
  final BookingRequest request;
  const RequestScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        CustomAppBar(
                            blendMode: BlendMode.exclusion,
                            backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
                            height: 35.h,
                            child: const SizedBox()),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 10.h,
                            backgroundColor: ColorManager.grey1,
                            backgroundImage: getDefaultNetworkImageProvider(request.userImage),
                          ),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                // focusColor: Colors.white,
                                color: ColorManager.primary,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.arrow_back_ios_new)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).viewProfile,
                            style: TextStyleManager.getGoldenRegularStyle(),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          const Icon(
                            Icons.arrow_forward_outlined,
                            color: ColorManager.golden,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(children: [
                        _buildRequestItem(S.of(context).userName, request.userName),
                        _buildRequestItem(
                            S.of(context).placeName,
                            cubit.places
                                .firstWhere((element) => element.id == request.placeId)
                                .name),
                        _buildRequestItem(
                            S.of(context).address,
                            cubit.places
                                .firstWhere((element) => element.id == request.placeId)
                                .address),
                        _buildRequestItem(
                            S.of(context).price, "${request.price} ${S.of(context).sar}"),
                        _buildRequestItem(S.of(context).date,
                            "${request.startTime.toDateString}    ${request.startTime.toTimeString} : ${request.endTime.toTimeString}"),
                        _buildRequestItem(S.of(context).bookingTime,
                            "${request.startTime.difference(request.endTime).abs().inMinutes} ${S.of(context).minutes}"),
                      ]))
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: BlocListener<PlaceCubit, PlaceState>(
                listener: (context, state) {
                  if (state is AcceptBookingRequestSuccess) {
                    defaultToast(msg: S.of(context).requestAccepted);
                    Navigator.pop(context);
                  } else if (state is DeclineBookingRequestSuccess) {
                    defaultToast(msg: S.of(context).requestRejected);
                    Navigator.pop(context);
                  } else if (state is PlaceError) {
                    errorToast(msg: ExceptionManager(state.exception).translatedMessage());
                  }
                },
                child: BlocBuilder<PlaceCubit, PlaceState>(
                    bloc: cubit,
                    builder: (context, state) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DefaultButton(
                                text: S.of(context).accept,
                                onPressed: () async {
                                  cubit.acceptBookingRequest(request.id!);
                                },
                                // height: 10.h,
                                width: 30.w,
                                isLoading: state is AcceptBookingRequestLoading,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: DefaultButton(
                                color: ColorManager.white,
                                textColor: ColorManager.black,
                                text: S.of(context).decline,
                                borderColor: ColorManager.black,
                                onPressed: () async {
                                  cubit.declineBookingRequest(request.id!);
                                },
                                width: 30.w,
                                isLoading: state is DeclineBookingRequestLoading,
                              ),
                            ),
                          ],
                        )),
              ))
        ],
      ),
    );
  }

  Widget _buildRequestItem(String title, String value) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: TextStyleManager.getSecondarySubTitleStyle()),
            const Spacer(),
            SubTitle(
              value,
              isBold: false,
            ),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
