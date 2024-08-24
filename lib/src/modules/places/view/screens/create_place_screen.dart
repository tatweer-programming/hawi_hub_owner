import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:sizer/sizer.dart';

class CreatePlaceScreen extends StatelessWidget {
  const CreatePlaceScreen({super.key});

  /*
   String name;
  String address;
  List<Day>? workingHours; // int day, String startTime, String endTime
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  int sportId;
  double price;
  int ownerId;
  int? minimumHours;
  List<String> images;
  List<File> imageFiles;
    */
  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    MainCubit mainCubit = MainCubit.get();
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController minimumHoursController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
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
                        S.of(context).addPlace,
                        style: TextStyleManager.getAppBarTextStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SingleChildScrollView(
                  child: Padding(
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
                                              suffixIcon:
                                                  cubit.workingHoursChanged ==
                                                          true
                                                      ? Icon(
                                                          Icons.check_circle,
                                                          color: ColorManager
                                                              .primary,
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
                                                    Routes.addWorkingHours);
                                              }))
                                    ],
                                  ),
                                )
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
                                if (double.tryParse(value) == null) {
                                  return S.of(context).invalidValue;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 1.5.h),
                            Row(children: [
                              Expanded(
                                child: BlocBuilder<MainCubit, MainState>(
                                  bloc: mainCubit,
                                  builder: (context, state) {
                                    return dropdownBuilder(
                                        text: cubit.selectedSport == null
                                            ? S.of(context).sport
                                            : mainCubit.sportsList
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    cubit.selectedSport!)
                                                .name,
                                        onChanged: (sport) {
                                          cubit.chooseSport(sport!);
                                        },
                                        items: mainCubit.sportsList
                                            .map((e) => e.name)
                                            .toList());
                                  },
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: dropdownBuilder(
                                    text: cubit.selectedCityId == null
                                        ? S.of(context).city
                                        : LocalizationManager.getSaudiCities[
                                            cubit.selectedCityId! - 1],
                                    onChanged: (city) {
                                      cubit.selectedCityId = LocalizationManager
                                              .getSaudiCities
                                              .indexOf(city!) +
                                          1;
                                      //print(cubit.selectedCityId);
                                    },
                                    items: LocalizationManager.getSaudiCities),
                              )
                            ]),
                            SizedBox(height: 5.h),
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
                                      ...cubit.imageFiles.map((i) {
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
                                                  cubit.removeImage(i.path);
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
                                          await cubit.addImages();
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
                                                    await cubit.addImages();
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
                            BlocBuilder<PlaceCubit, PlaceState>(
                              bloc: cubit,
                              builder: (context, state) {
                                return Stack(
                                  children: [
                                    TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.add,
                                          color: ColorManager.transparent,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          borderSide: BorderSide(
                                              color:
                                                  cubit.selectedOwnershipFile ==
                                                          null
                                                      ? ColorManager.black
                                                      : ColorManager.primary),
                                        ),
                                        labelStyle: Theme.of(context)
                                            .inputDecorationTheme
                                            .labelStyle,
                                        labelText:
                                            cubit.selectedOwnershipFile == null
                                                ? S.of(context).ownershipFile
                                                : cubit
                                                    .selectedOwnershipFile!.path
                                                    .split('/')
                                                    .last,
                                      ),
                                    ),
                                    Positioned.fill(
                                        child: InkWell(
                                            customBorder: Border.all(
                                                color:
                                                    cubit.selectedOwnershipFile ==
                                                            null
                                                        ? ColorManager.black
                                                        : ColorManager.primary),
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            onTap: () async {
                                              if (cubit.selectedOwnershipFile ==
                                                  null) {
                                                await cubit
                                                    .selectOwnershipFile();
                                              } else {
                                                await OpenFile.open(cubit
                                                    .selectedOwnershipFile!
                                                    .path);
                                              }
                                            })),
                                    Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: IconButton(
                                            onPressed: () async {
                                              await cubit.selectOwnershipFile();
                                            },
                                            icon: Icon(
                                              cubit.selectedOwnershipFile ==
                                                      null
                                                  ? Icons.attachment
                                                  : Icons.edit,
                                            ))),
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Tooltip(
                                        child: IconButton(
                                          onPressed: () async {
                                            tooltipKey.currentState!.activate();
                                          },
                                          icon: Tooltip(
                                            child: Icon(
                                              Icons.help,
                                              fill: 1,
                                            ),
                                            key: tooltipKey,
                                            triggerMode: TooltipTriggerMode.tap,
                                            message:
                                                S.of(context).ownershipTypes,
                                            enableTapToDismiss: true,
                                            preferBelow: false,
                                            showDuration:
                                                const Duration(seconds: 2),
                                            waitDuration:
                                                const Duration(seconds: 2),
                                            exitDuration:
                                                const Duration(seconds: 2),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        message: S.of(context).ownershipTypes,
                                        triggerMode: TooltipTriggerMode.tap,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ]))),
                ),
              ],
            )),
          ),
          BlocListener<PlaceCubit, PlaceState>(
            listener: (context, state) {
              if (state is CreatePlaceSuccess) {
                defaultToast(msg: S.of(context).placeAdded);
                context.pop();
              } else if (state is CreatePlaceError) {
                errorToast(
                    msg: ExceptionManager(state.exception).translatedMessage());
              } else if (state is PickLocationSuccess) {
                addressController.text = state.address;
                defaultToast(msg: S.of(context).locationSaved);
              }
            },
            child: BlocBuilder<PlaceCubit, PlaceState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: DefaultButton(
                      isLoading: state is CreatePlaceLoading,
                      enabled: state is! UploadAttachmentsLoading,
                      text: state is UploadAttachmentsLoading
                          ? S.of(context).uploadingAttachment
                          : S.of(context).addPlace,
                      onPressed: () async {
                        if (_checkCreateValidation(formKey)) {
                          PlaceCreationForm placeCreationForm =
                              PlaceCreationForm(
                            name: nameController.text,
                            description: descriptionController.text,
                            address: addressController.text,
                            minimumHours:
                                int.tryParse(minimumHoursController.text),
                            ownerId: ConstantsManager.userId!,
                            sportId: cubit.selectedSport!,
                            price: double.tryParse(priceController.text) ?? 0.0,
                            location: cubit.placeLocation,
                            workingHours: PlaceCubit.get().workingHours,
                            imageFiles: cubit.imageFiles,
                            ownershipFile: cubit.selectedOwnershipFile!,
                            cityId: cubit.selectedCityId!,
                          );
                          await PlaceCubit.get().createPlace(placeCreationForm);
                        } else {
                          showRequiredFieldToast(context);
                        }
                      }),
                );
              },
            ),
          ),
          SizedBox(height: 1.5.h),
        ],
      ),
    );
  }

  bool _checkCreateValidation(
    GlobalKey<FormState> key,
  ) {
    PlaceCubit cubit = PlaceCubit.get();
    return (key.currentState!.validate() &&
        cubit.selectedSport != null &&
        cubit.selectedCityId != null &&
        cubit.imageFiles.isNotEmpty &&
        cubit.selectedOwnershipFile != null);
  }

  void showRequiredFieldToast(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    if (cubit.selectedSport == null) {
      errorToast(msg: S.of(context).sportIsRequired);
    }
    if (cubit.selectedCityId == null) {
      errorToast(msg: S.of(context).cityIsRequired);
    }
    if (cubit.imageFiles.isEmpty) {
      errorToast(msg: S.of(context).imageIsRequired);
    }
    if (cubit.selectedOwnershipFile == null) {
      errorToast(msg: S.of(context).ownerShipIsRequired);
    }
  }
}
