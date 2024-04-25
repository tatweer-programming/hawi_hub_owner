import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../main/view/widgets/components.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../../data/models/place.dart';

class PlaceScreen extends StatelessWidget {
  final int placeId;

  const PlaceScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // app bar
                SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      CustomAppBar(
                          blendMode: BlendMode.exclusion,
                          backgroundImage: "assets/images/app_bar_backgrounds/6.webp",
                          height: 35.h,
                          child: const SizedBox()),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: 95.w,
                            height: 30.h,
                            child: Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlay: true,
                                    pauseAutoPlayInFiniteScroll: true,
                                    pauseAutoPlayOnTouch: true,
                                    // aspectRatio: 90.w / 30.h,
                                    viewportFraction: 0.99,
                                    padEnds: false,
                                    pauseAutoPlayOnManualNavigate: true,
                                    height: 30.h,
                                  ),
                                  items: cubit.currentPlace!.images.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: 88.w,
                                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.grey,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(i),
                                              )),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
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
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        // focusColor: Colors.white,
                                        color: ColorManager.primary,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.edit),
                                                    title: Text(S.of(context).editPlace),
                                                    onTap: () {
                                                      Navigator.pop(context); // Close bottom sheet
                                                      // Navigate to edit place screen
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (context) => EditPlaceScreen(placeId: placeId),
                                                      //   ),
                                                      // );
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(Icons.delete),
                                                    title: Text(S.of(context).deletePlace),
                                                    onTap: () {
                                                      Navigator.pop(context); // Close bottom sheet
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) => AlertDialog(
                                                          title: Text(S.of(context).confirmDelete),
                                                          content: Text(S
                                                              .of(context)
                                                              .deletePlaceConfirmation),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                ctx.pop(); // Close dialog
                                                              },
                                                              child: Text(S.of(context).cancel),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                // Delete place and navigate back
                                                                PlaceCubit.get()
                                                                    .deletePlace(placeId);
                                                                ctx.pushAndRemove(Routes.home);
                                                              },
                                                              child: Text(S.of(context).delete),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.more_vert)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(cubit.currentPlace!.name),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        cubit.currentPlace!.address,
                        style: TextStyleManager.getRegularStyle(),
                      ),
                      SizedBox(
                        width: 45.w,
                        child: Divider(
                          height: 5.h,
                        ),
                      ),
                      SubTitle(S.of(context).location),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        cubit.currentPlace!.address,
                        style: TextStyleManager.getCaptionStyle(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      _buildShowMapWidget(context),
                      Divider(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 4.h,
                        child: Row(
                          children: [
                            Expanded(
                                child: (cubit.currentPlace!.rating != null)
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cubit.currentPlace!.rating.toString(),
                                            style: TextStyleManager.getBlackCaptionTextStyle(),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: SizedBox(
                                                height: 20.sp,
                                                child: RatingBar.builder(
                                                  glow: true,
                                                  itemSize: 20.sp,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  wrapAlignment: WrapAlignment.center,
                                                  initialRating: cubit.currentPlace!.rating!,
                                                  itemCount: 5,
                                                  glowColor: ColorManager.golden,
                                                  ignoreGestures: true,
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: ColorManager.golden,
                                                  ),
                                                  onRatingUpdate: (r) {},
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Center(
                                        child: Text(S.of(context).noRatings),
                                      )),
                            const VerticalDivider(),
                            Expanded(
                                child: Row(
                              children: [
                                Text(cubit.currentPlace!.totalGames.toString()),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(S.of(context).totalGames,
                                    style: TextStyleManager.getBlackCaptionTextStyle()),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: SizedBox(
                          height: 7.h,
                          child: Row(
                            children: [
                              Expanded(child: _buildUserRatingWidget(context, true)),
                              SizedBox(
                                width: 3.w,
                              ),
                              // Expanded(
                              //     child: OutLineContainer(
                              //       child: Text(
                              //         "${cubit.currentPlac} ${S.of(context).upcoming}",
                              //       ),
                              //     )),
                            ],
                          ),
                        ),
                      ),
                      SubTitle(S.of(context).sport),
                      SizedBox(
                        height: 1.h,
                      ),
                      _buildSportWidget(
                          MainCubit.get()
                              .sportsList
                              .firstWhere((element) => cubit.currentPlace!.sportId == element.id)
                              .name,
                          context),
                      SizedBox(
                        height: 3.h,
                      ),
                      SubTitle(S.of(context).details),
                      SizedBox(
                        height: 1.h,
                      ),
                      _buildCaptionWidget(cubit.currentPlace!.description ?? ""),
                      Divider(
                        height: 4.h,
                      ),
                      SubTitle(S.of(context).booking),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                S.of(context).price,
                              ),
                            ),
                          ),
                          const VerticalDivider(),
                          Expanded(
                            child: Center(
                              child: Text(
                                S.of(context).minimumBooking,
                              ),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 5.h,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Expanded(
                            child: OutLineContainer(
                              child: Text(
                                "${cubit.currentPlace!.price}  ${S.of(context).sar} ${S.of(context).perHour}",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: OutLineContainer(
                              child: Text(
                                "${cubit.currentPlace!.minimumHours}  ${S.of(context).hours}",
                              ),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: DefaultButton(
              text: S.of(context).addBooking,
              onPressed: () {
                debugPrint("Book Now");
              }),
        ),
      ],
    ));
  }

  Widget _buildShowMapWidget(BuildContext context) {
    return Container(
        height: 4.h,
        width: 35.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Row(
          children: [
            Icon(
              color: ColorManager.error,
              Icons.location_on,
            ),
            Expanded(
              child: Text(
                S.of(context).showInMap,
                style: TextStyleManager.getSecondaryRegularStyle(),
              ),
            ),
          ],
        )));
  }

  Widget _buildUserRatingWidget(BuildContext context, bool hasRated) {
    return OutLineContainer(
        child: Center(
      child: SizedBox(
        height: 20.sp,
        child: RatingBar.builder(
          glow: true,
          itemSize: 20.sp,
          direction: Axis.horizontal,
          allowHalfRating: true,
          wrapAlignment: WrapAlignment.center,
          initialRating: 2.5,
          // user rating
          itemCount: 5,
          glowColor: ColorManager.golden,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: ColorManager.golden,
          ),
          onRatingUpdate: (r) {},
        ),
      ),
    ));
  }

  Widget _buildSportWidget(String sport, BuildContext context) {
    return Container(
      height: 5.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.grey1,
      ),
      child: InkWell(
          onTap: () {
            // TODO navigate to sport Screen
          },
          child: Center(child: Text(sport, style: TextStyleManager.getBlackCaptionTextStyle()))),
    );
  }

  Widget _buildCaptionWidget(String caption) {
    return Text(caption, style: TextStyleManager.getCaptionStyle());
  }
}
