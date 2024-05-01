import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/request_shimmers.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/connectivity.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../../data/models/booking_request.dart';

class AllRequestsPage extends StatelessWidget {
  const AllRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectionWidget(
      onRetry: retryConnecting,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.topCenter,
            heightFactor: 0.85,
            child: CustomAppBar(
              height: 33.h,
              opacity: .15,
              backgroundImage: "assets/images/app_bar_backgrounds/1.webp",
              actions: [
                IconButton(
                    onPressed: () {
                      context.push(Routes.notifications);
                    },
                    icon: const ImageIcon(
                      AssetImage("assets/images/icons/notification.webp"),
                      color: ColorManager.golden,
                    )),
                InkWell(
                  radius: 360,
                  onTap: () {
                    context.push(Routes.profile);
                  },
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-649.jpg?t=st=1711503056~exp=1711506656~hmac=9aea7449b3ae3f763053d68d15a49e3c70fa1e73e98311d518de5f01c2c3d41c&w=740"),
                    backgroundColor: ColorManager.golden,
                  ),
                ),
              ],
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: SizedBox(
                  height: 7.h,
                  child: Text(
                    S.of(context).requests,
                    style: TextStyleManager.getAppBarTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<PlaceCubit, PlaceState>(
              bloc: PlaceCubit.get(),
              builder: (context, state) {
                return (state is GetBookingRequestsLoading)
                    ? const VerticalRequestsShimmer()
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                BookingRequestWidget(bookingRequest: bookingRequests[index]),
                            separatorBuilder: (itemContext, index) => const Divider(),
                            itemCount: bookingRequests.length),
                      );
              })
        ],
      ),
    );
  }

  void retryConnecting() {
    PlaceCubit.get().getBookingRequests();
  }
}

List<BookingRequest> bookingRequests = [
  BookingRequest(
    id: 1,
    price: 200,
    userId: 1,
    address: "address",
    endTime: DateTime.now().add(const Duration(hours: 1)),
    startTime: DateTime.now(),
    placeName: "place",
    userName: "username",
    userImage:
        "https://images.pexels.com/photos/1036627/pexels-photo-1036627.jpeg?auto=compress&cs=tinysrgb&w=600",
    placeId: 1,
  ),
  BookingRequest(
    id: 1,
    price: 200,
    userId: 1,
    address: "address",
    endTime: DateTime.now().add(const Duration(hours: 1)),
    startTime: DateTime.now(),
    placeName: "place",
    userName: "username",
    userImage: "assets/images/user.png",
    placeId: 1,
  ),
  BookingRequest(
    id: 1,
    price: 200,
    userId: 1,
    address: "address",
    endTime: DateTime.now().add(const Duration(hours: 1)),
    startTime: DateTime.now(),
    placeName: "place",
    userName: "username",
    userImage: "assets/images/user.png",
    placeId: 1,
  ),
  BookingRequest(
    id: 1,
    price: 200,
    userId: 1,
    address: "address",
    endTime: DateTime.now().add(const Duration(hours: 1)),
    startTime: DateTime.now(),
    placeName: "place",
    userName: "username",
    userImage: "assets/images/user.png",
    placeId: 1,
  )
];
