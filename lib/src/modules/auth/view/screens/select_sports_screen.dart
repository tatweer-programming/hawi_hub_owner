import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common%20widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/sport.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/auth_bloc.dart';

class SelectSportsScreen extends StatelessWidget {
  const SelectSportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Sport> sports = [];
    List<Sport> selectedSports = [];
    final AuthBloc authBloc = AuthBloc.get(context)..add(GetSportsEvent());
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SelectSportState) {
          selectedSports = state.sports;
        }
        if (state is GetSportsSuccessState) {
          sports = state.sports;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          CustomAppBar(
                            blendMode: BlendMode.exclusion,
                            height: 35.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    "What do you wanna play ?",
                                    style: TextStyle(
                                        color: ColorManager.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    height: 6.h,
                                    child: TextField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          hintText: "Type",
                                          border: InputBorder.none,
                                          suffixIcon: const Icon(Icons.search),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 5.w,
                          children: List.generate(
                            sports.length,
                            (index) => _categoryBuilder(
                                selectedSports: selectedSports,
                                sport: sports[index],
                                onTap: () {
                                  authBloc.add(
                                    SelectSportEvent(
                                        sport: sports[index],
                                        sports: selectedSports),
                                  );
                                }),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            defaultButton(
              onPressed: () {},
              text: "MAKE MY DEBUT",
              fontSize: 17.sp,
              buttonColor: selectedSports.isNotEmpty
                  ? ColorManager.primary
                  : ColorManager.grey3,
            ),
            SizedBox(
              height: 4.h,
            )
          ],
        );
      },
    ));
  }
}

Widget _categoryBuilder(
    {required Sport sport,
    required Function() onTap,
    required List<Sport> selectedSports}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20.sp),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: AnimatedContainer(
        height: 13.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: selectedSports.contains(sport)
              ? ColorManager.primary
              : ColorManager.grey2,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.bounceOut,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 12.5.w,
                  end: (selectedSports.contains(sport) ? 12.5 : 2).w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 2.h,
                      bottom: 1.h,
                    ),
                    child: Container(
                      height: 6.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: 15.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        image: DecorationImage(
                          image: NetworkImage(sport.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (!selectedSports.contains(sport))
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 1.h, start: 2.w),
                      child: Icon(
                        Icons.add,
                        size: 25.sp,
                        color: ColorManager.grey3,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                sport.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
