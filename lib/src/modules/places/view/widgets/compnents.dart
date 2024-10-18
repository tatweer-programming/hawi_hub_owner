import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/offline_booking.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

import '../../../main/view/widgets/components.dart';

class BookingRequestWidget extends StatelessWidget {
  final BookingRequest bookingRequest;

  const BookingRequestWidget({super.key, required this.bookingRequest});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    return InkWell(
      onTap: () {
        context.push(Routes.request, arguments: {"request": bookingRequest});
      },
      child: Container(
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
                const Spacer(),
                InkWell(
                  onTap: () {
                    context.push(Routes.bookingRequestDetails,
                        arguments: {"id": bookingRequest.id});
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
                      backgroundImage: getDefaultNetworkImageProvider(
                          bookingRequest.userImage),
                      radius: 10.w,
                      child: InkWell(onTap: () {
                        context.push(Routes.profile,
                            arguments: {"id": bookingRequest.userId});
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
                                  await cubit
                                      .acceptBookingRequest(bookingRequest.id!);
                                },
                                height: 10.h,
                                width: 30.w,
                                isLoading:
                                    state is AcceptBookingRequestLoading &&
                                        state.requestId == bookingRequest.id,
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
                                  await cubit.declineBookingRequest(
                                      bookingRequest.id!);
                                },
                                width: 30.w,
                                isLoading:
                                    state is DeclineBookingRequestLoading &&
                                        state.requestId == bookingRequest.id,
                              ),
                            ),
                          ],
                        ))),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}

class PlaceItem extends StatelessWidget {
  final Place place;

  const PlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 70.w,
      child: Card(
        color: ColorManager.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.grey1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            context.push(Routes.place, arguments: {"id": place.id});
          },
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Hero(
                  tag: place.id,
                  transitionOnUserGestures: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                        onError: (__, _) =>
                            ColoredBox(color: ColorManager.grey1),
                        image: NetworkImage(
                            ApiManager.handleImageUrl(place.images.first)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubTitle(
                          place.name,
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            place.address,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyleManager.getCaptionStyle(),
                          ),
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        Text(
                          "${place.price} ${S.of(context).sar}/hour",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyleManager.getCaptionStyle(),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget dropdownBuilder(
    {required String text,
    IconData? icon,
    required Function(String? value) onChanged,
    required List<String> items}) {
  return DropdownMenu<String>(
    // errorText: text,
    // controller: TextEditingController(),
    label: Text(text),
    enableFilter: false,
    requestFocusOnTap: false,
    expandedInsets: EdgeInsets.zero,
    enableSearch: false,
    leadingIcon: Icon(
      icon ?? Icons.search,
      color: ColorManager.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.secondary,
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
      contentPadding: EdgeInsets.symmetric(horizontal: 1.w),
    ),
    onSelected: onChanged,
    menuHeight: 50.h,
    dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
      (String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      },
    ).toList(),
  );
}

class BookingItem extends StatelessWidget {
  final BookingRequest bookingRequest;

  const BookingItem({super.key, required this.bookingRequest});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    child: CircleAvatar(
                      backgroundImage: getDefaultNetworkImageProvider(
                          bookingRequest.userImage),
                      child: InkWell(onTap: () {
                        context.push(Routes.profile,
                            arguments: {"id": bookingRequest.userId});
                      }),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                SubTitle(
                  bookingRequest.userName,
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 1.w),
                        Expanded(
                            child: TitleText(
                          cubit.places
                              .firstWhere((x) => x.id == bookingRequest.placeId)
                              .name,
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: 1.w),
                        Text(
                          bookingRequest.startTime.toString().substring(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.watch_later_outlined),
                        SizedBox(width: 1.w),
                        Text(
                          bookingRequest.startTime
                                  .toString()
                                  .substring(11, 16) +
                              " - " +
                              bookingRequest.endTime
                                  .toString()
                                  .substring(11, 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class OfflineBookingItem extends StatelessWidget {
  final OfflineBooking offlineBooking;

  const OfflineBookingItem({super.key, required this.offlineBooking});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    return Container(
      padding: const EdgeInsets.all(15),
      height: 15.h,
      width: 90.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorManager.black, width: .6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 1.w),
                Expanded(
                    child: TitleText(
                  cubit.places
                      .firstWhere((x) => x.id == offlineBooking.placeId)
                      .name,
                ))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(Icons.calendar_month),
                SizedBox(width: 1.w),
                Text(
                  offlineBooking.startTime.toString().substring(0, 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 1.w),
                Text(
                  offlineBooking.startTime.toString().substring(11, 16) +
                      " - " +
                      offlineBooking.endTime.toString().substring(11, 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
