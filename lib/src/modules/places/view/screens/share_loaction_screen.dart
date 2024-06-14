import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class PickLocationScreen extends StatelessWidget {
  const PickLocationScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          buttonColor: ColorManager.primary,
          buttonText: S.of(context).pickLocation,
          onPicked: (pickedData) {
            PlaceCubit.get().placeLocation = PlaceLocation(
                latitude: pickedData.latLong.latitude,
                longitude: pickedData.latLong.longitude);
            defaultToast(msg: S.of(context).locationSaved);
            context.pop();
          }),
    );
  }
}
