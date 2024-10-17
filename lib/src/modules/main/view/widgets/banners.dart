import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/image_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    Key? key,
  }) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return Column(
      children: [
        BlocBuilder<MainCubit, MainState>(
          bloc: mainCubit,
          builder: (context, state) {
            return Skeletonizer(
              enabled: state is GetBannersLoading,
              effect: const PulseEffect(),
              justifyMultiLineText: false,
              ignorePointers: false,
              ignoreContainers: false,
              containersColor: ColorManager.grey1,
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlay: true,
                  viewportFraction: .95,
                  padEnds: false,
                  pauseAutoPlayOnManualNavigate: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: state is GetBannersLoading ||
                        mainCubit.bannerList.isEmpty
                    ? dummyBanners.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Container(
                                width: 88.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList()
                    : mainCubit.bannerList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ImageWidget(
                                i,
                                width: 88.w,
                                borderRadius: 20,
                              ),
                            );
                          },
                        );
                      }).toList(),
              ),
            );
          },
        ),

        // مؤشر الـ Carousel
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mainCubit.bannerList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() {
                _currentIndex = entry.key;
              }),
              child: Container(
                width: _currentIndex == entry.key ? 10.0 : 8.0,
                height: _currentIndex == entry.key ? 10.0 : 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? ColorManager.golden
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

List<String> dummyBanners = [
  "",
  "",
  "",
  "",
];
