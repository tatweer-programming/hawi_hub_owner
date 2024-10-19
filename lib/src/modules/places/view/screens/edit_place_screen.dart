import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/localization_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class EditPlaceScreen extends StatelessWidget {
  final int placeId;

  const EditPlaceScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    TextEditingController nameController =
        TextEditingController(text: cubit.placeEditForm!.name);
    TextEditingController descriptionController =
        TextEditingController(text: cubit.placeEditForm!.description);
    TextEditingController addressController =
        TextEditingController(text: cubit.placeEditForm!.address);
    TextEditingController minimumHoursController = TextEditingController(
        text: cubit.placeEditForm!.minimumHours?.toString());
    TextEditingController priceController = TextEditingController(
      text: cubit.placeEditForm!.price.toString(),
    );
    TextEditingController depositController = TextEditingController(
      text: cubit.placeEditForm!.deposit.toString(),
    );

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    debugPrint("deposit : ${cubit.placeEditForm!.deposit}");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        S.of(context).editPlace,
                        style: TextStyleManager.getAppBarTextStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                        key: formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: S.of(context).placeName,
                              hintText: S.of(context).placeName,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).requiredField;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 1.5.h),
                          SizedBox(
                            height: 25.h,
                            child: TextFormField(
                                // expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.multiline,
                                textDirection:
                                    LocalizationManager.getCurrentLocale()
                                                .languageCode ==
                                            'ar'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                expands: true,
                                maxLines: null,
                                minLines: null,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  labelText: S.of(context).description,
                                  hintText: S.of(context).description,
                                )),
                          ),
                          SizedBox(height: 1.5.h),
                          TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context.push(Routes.pickLocation);
                                  },
                                  icon: const Icon(
                                      Icons.add_location_alt_outlined),
                                ),
                                labelText: S.of(context).address,
                                hintText: S.of(context).address,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).requiredField;
                                }
                                return null;
                              }),
                          SizedBox(height: 1.5.h),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: minimumHoursController,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).minimumHours,
                                    hintText: S.of(context).minimumBooking,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Stack(
                                  children: [
                                    BlocBuilder<PlaceCubit, PlaceState>(
                                      bloc: cubit,
                                      buildWhen: (previous, current) =>
                                          cubit.workingHoursChanged == true,
                                      builder: (context, state) {
                                        return TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            suffixIcon: cubit
                                                        .workingHoursChanged ==
                                                    true
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: ColorManager.primary,
                                                  )
                                                : null,
                                            labelStyle: Theme.of(context)
                                                .inputDecorationTheme
                                                .labelStyle,
                                            labelText:
                                                S.of(context).workingHours,
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned.fill(
                                        child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            onTap: () {
                                              context.push(
                                                  Routes.editWorkingHours);
                                            }))
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.5.h),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: depositController,
                                  decoration: InputDecoration(
                                      labelText: S.of(context).deposit,
                                      hintText: S.of(context).deposit + " %",
                                      suffix: Text(
                                        "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S.of(context).requiredField;
                                    }
                                    if (double.tryParse(value) == null ||
                                        double.parse(value) <= 0) {
                                      return S.of(context).invalidValue;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: BlocBuilder<PlaceCubit, PlaceState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    List<String> genders = [
                                      S.of(context).males,
                                      S.of(context).females,
                                      S.of(context).both
                                    ];
                                    return dropdownBuilder(
                                        text: S.of(context).genders,
                                        onChanged: (gender) {
                                          cubit.chooseGender(gender!);
                                          cubit.placeEditForm!.genders =
                                              cubit.selectedGender;
                                        },
                                        items: genders);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.5.h),
                          TextFormField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: S.of(context).price,
                              hintText:
                                  S.of(context).price + S.of(context).perHour,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).requiredField;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 1.5.h),
                          // Row(children: [
                          //   Expanded(
                          //     child: BlocBuilder<MainCubit, MainState>(
                          //       bloc: MainCubit.get(),
                          //       builder: (context, state) {
                          //         return dropdownBuilder(
                          //             text: MainCubit.get()
                          //                 .sportsList
                          //                 .firstWhere(
                          //                     (element) => element.id == cubit.placeEditForm!.sport,
                          //                     orElse: () => MainCubit.get().sportsList[0])
                          //                 .name,
                          //             onChanged: (sport) {
                          //               cubit.selectedSport = MainCubit.get()
                          //                   .sportsList
                          //                   .firstWhere((element) => element.name == sport,
                          //                       orElse: () => MainCubit.get().sportsList[0])
                          //                   .id;
                          //               //print(cubit.selectedSport);
                          //             },
                          //             items:
                          //                 MainCubit.get().sportsList.map((e) => e.name).toList());
                          //       },
                          //     ),
                          //   ),
                          //   SizedBox(width: 2.w),
                          //   Expanded(
                          //     child: dropdownBuilder(
                          //         text: cubit.selectedCityId == null
                          //             ? LocalizationManager
                          //                 .getSaudiCities[cubit.placeEditForm!.cityId]
                          //             : LocalizationManager.getSaudiCities[cubit.selectedCityId!],
                          //         onChanged: (city) {
                          //           cubit.selectedCityId =
                          //               LocalizationManager.getSaudiCities.indexOf(city!);
                          //           //print(cubit.selectedCityId);
                          //         },
                          //         items: LocalizationManager.getSaudiCities),
                          //   )
                          // ]),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              BlocBuilder<PlaceCubit, PlaceState>(
                                bloc: cubit,
                                builder: (context, state) {
                                  return Checkbox(
                                      value: cubit.placeEditForm!.isShared,
                                      onChanged: (c) {
                                        cubit.placeEditForm!.isShared = c!;
                                        cubit.changeIsShared(c);
                                      });
                                },
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: Text(
                                  S.of(context).canShare,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            height: 30.h,
                            decoration: BoxDecoration(
                              // border: cubit.imageFiles.isEmpty ? Border.all() : null,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: BlocBuilder<PlaceCubit, PlaceState>(
                              bloc: cubit,
                              builder: (context, state) {
                                return CarouselSlider(
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    enlargeCenterPage: true,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlay: true,
                                    pauseAutoPlayInFiniteScroll: true,
                                    pauseAutoPlayOnTouch: true,
                                    // aspectRatio: 90.w / 30.h,
                                    viewportFraction: 0.90,
                                    padEnds: false,
                                    pauseAutoPlayOnManualNavigate: true,
                                    height: 30.h,
                                  ),
                                  items: [
                                    ...cubit.placeEditForm!.images.map((i) {
                                      return Stack(
                                        children: [
                                          Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 88.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          ApiManager
                                                              .handleImageUrl(
                                                                  i)),
                                                    )),
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            child: IconButton(
                                              onPressed: () {
                                                cubit
                                                    .removeNetworkImageFromEditForm(
                                                        i);
                                              },
                                              icon: CircleAvatar(
                                                backgroundColor: ColorManager
                                                    .black
                                                    .withOpacity(.5),
                                                child: const Icon(
                                                  Icons.remove_circle_outline,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                    ...cubit.placeEditForm!.imageFiles.map((i) {
                                      return Stack(
                                        children: [
                                          Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: 88.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(i),
                                                    )),
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            child: IconButton(
                                              onPressed: () {
                                                cubit.removeImageFromEditForm(
                                                    i.path);
                                              },
                                              icon: CircleAvatar(
                                                backgroundColor: ColorManager
                                                    .black
                                                    .withOpacity(.5),
                                                child: const Icon(
                                                  Icons.remove_circle_outline,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                    InkWell(
                                      onTap: () async {
                                        await cubit.addImagesToEditForm();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  await cubit
                                                      .addImagesToEditForm();
                                                },
                                                icon: const Icon(Icons
                                                    .add_photo_alternate_outlined),
                                              ),
                                              Text(S.of(context).addImages)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ]))),
              ],
            )),
          ),
          BlocListener<PlaceCubit, PlaceState>(
            listener: (context, state) {
              if (state is UpdatePlaceSuccess) {
                defaultToast(msg: S.of(context).placeEditedSuccessfully);
                context.pop();
              } else if (state is PlaceError) {
                errorToast(
                    msg: ExceptionManager(state.exception).translatedMessage());
              } else if (state is PickLocationSuccess) {
                addressController.text = state.address;
                cubit.placeEditForm!.location = cubit.placeLocation;
                defaultToast(msg: S.of(context).locationSaved);
              }
            },
            child: BlocBuilder<PlaceCubit, PlaceState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: DefaultButton(
                      isLoading: state is UpdatePlaceLoading,
                      text: S.of(context).editPlace,
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            validateImages()) {
                          PlaceEditForm placeEditForm = PlaceEditForm(
                              name: nameController.text,
                              description: descriptionController.text,
                              address: addressController.text,
                              minimumHours: double.tryParse(
                                      minimumHoursController.text) ??
                                  cubit.placeEditForm?.minimumHours,
                              ownerId: cubit.currentPlace!.ownerId,
                              sport: cubit.selectedSport ??
                                  cubit.currentPlace!.sport,
                              price: double.parse(priceController.text),
                              location: cubit.placeEditForm?.location,
                              workingHours: PlaceCubit.get().workingHours,
                              imageFiles: cubit.placeEditForm!.imageFiles,
                              images: cubit.placeEditForm!.images,
                              deposit: double.parse(depositController.text),
                              cityId: cubit.placeEditForm!.cityId,
                              isShared: cubit.placeEditForm!.isShared,
                              genders: cubit.placeEditForm!.genders);
                          await PlaceCubit.get()
                              .updatePlace(placeId, newPlace: placeEditForm);
                        } else {
                          showRequiredFieldToast(context);
                        }
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showRequiredFieldToast(BuildContext context) {
    if (validateImages() == false) {
      errorToast(msg: S.of(context).imageIsRequired);
    }
  }

  bool validateImages() {
    return PlaceCubit.get().placeEditForm!.imageFiles.isNotEmpty ||
        PlaceCubit.get().placeEditForm!.images.isNotEmpty;
  }
}
