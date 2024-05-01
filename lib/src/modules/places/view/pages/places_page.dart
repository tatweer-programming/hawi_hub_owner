import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common%20widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
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
              errorToast(msg: ExceptionManager(state.exception).translatedMessage());
            }
          },
          child: BlocBuilder<PlaceCubit, PlaceState>(builder: (context, state) {
            if (state is GetPlacesLoading) {
              return const VerticalPlacesShimmer();
            }
            return Column(
              children: [
                CustomAppBar(
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
                        S.of(context).yourPlaces,
                        style: TextStyleManager.getAppBarTextStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (itemBuilder, index) => PlaceItem(place: cubit.places[index]),
                    separatorBuilder: (itemBuilder, index) => SizedBox(height: 2.h),
                    itemCount: cubit.places.length),
              ],
            );
          }),
        ));
  }
}
