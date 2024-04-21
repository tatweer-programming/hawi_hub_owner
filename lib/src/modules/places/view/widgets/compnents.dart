import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

import '../../../main/view/widgets/components.dart';

class BookingRequestWidget extends StatelessWidget {
  final BookingRequest bookingRequest;
  const BookingRequestWidget({super.key, required this.bookingRequest});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    return Container(
      padding: const EdgeInsets.all(15),
      height: 20.h,
      width: 90.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorManager.black, width: .6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  context.push(Routes.bookingRequestDetails, arguments: {"id": bookingRequest.id});
                },
                child: Text(S.of(context).viewDetails,
                    style: TextStyleManager.getGoldenRegularStyle()),
              ),
              const Icon(
                Icons.arrow_forward,
                color: ColorManager.golden,
              )
            ],
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(bookingRequest.userImage),
                    radius: 10.w,
                    child: InkWell(onTap: () {
                      context.push(Routes.profile, arguments: {"id": bookingRequest.userId});
                    }),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                      child: TitleText(
                    bookingRequest.userName,
                  ))
                ],
              )),
          SizedBox(height: 2.h),
          Expanded(
              flex: 2,
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
                                cubit.acceptBookingRequest(bookingRequest.id);
                              },
                              height: 10.h,
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
                                cubit.declineBookingRequest(bookingRequest.id);
                              },
                              width: 30.w,
                              isLoading: state is DeclineBookingRequestLoading,
                            ),
                          ),
                        ],
                      ))),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}

class PlaceItem extends StatelessWidget {
  final Place place;
  const PlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.place, arguments: {"id": place.id});
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        width: 90.w,
        height: 27.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp), border: Border.all()),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: double.infinity,
                  height: 15.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(place.images.first),
                      )),
                ),
                Expanded(
                    child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleManager.getSubTitleBoldStyle(),
                            ),
                          ),
                          Text(S.of(context).viewDetails,
                              style: TextStyleManager.getGoldenRegularStyle()),
                          const Icon(
                            Icons.arrow_forward,
                            color: ColorManager.golden,
                          )
                        ],
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          place.address,
                          style: TextStyleManager.getCaptionStyle(),
                        ),
                      ),
                    ]),
                  ),
                ]))
              ]),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outlined,
                    color: Colors.red,
                  )),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  height: 3.h,
                  constraints: BoxConstraints(minWidth: 20.w, maxWidth: 50.w),
                  child: Center(
                    child: Text(place.ownerName,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleManager.getBlackContainerTextStyle()),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
