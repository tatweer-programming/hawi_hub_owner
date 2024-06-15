import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

class PlaceFeedbacksScreen extends StatelessWidget {
  final int id;
  const PlaceFeedbacksScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit = PlaceCubit.get();
    Place currentPlace = placeCubit.places.firstWhere((element) => element.id == id);
    if (currentPlace.feedbacks == null || currentPlace.feedbacks!.isEmpty) {
      placeCubit.getPlaceFeedbacks(id);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              actions: [
                SizedBox(
                  height: 5.h,
                )
              ],
              height: 33.h,
              opacity: .15,
              backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: SizedBox(
                  height: 7.h,
                  child: Text(
                    S.of(context).feedbacks,
                    style: TextStyleManager.getAppBarTextStyle(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: BlocBuilder<PlaceCubit, PlaceState>(
                  bloc: placeCubit,
                  builder: (context, state) {
                    return state is GetPlaceReviewsLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : currentPlace.feedbacks!.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Center(child: SubTitle(S.of(context).noFeedbacks)),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: currentPlace.feedbacks!.length,
                                itemBuilder: (context, index) {
                                  return FeedBackWidget(feedBack: currentPlace.feedbacks![index]);
                                });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
