import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/compnents.dart';
import 'package:hawi_hub_owner/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:sizer/sizer.dart';

class AllPlacesPage extends StatelessWidget {
  const AllPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();

    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: ConnectionWidget(onRetry: () {
        cubit.getPlaces();
      }, child: BlocBuilder<PlaceCubit, PlaceState>(builder: (context, state) {
        if (state is GetPlacesLoading) {
          return VerticalPlacesShimmer();
        }
        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (itemBuilder, index) => PlaceItem(place: cubit.places[index]),
            separatorBuilder: (itemBuilder, index) => SizedBox(height: 2.h),
            itemCount: cubit.places.length);
      })),
    );
  }
}
