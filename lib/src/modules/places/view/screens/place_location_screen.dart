import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class PlaceLocationScreen extends StatelessWidget {
  final PlaceLocation location;
  const PlaceLocationScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).location),
      ),
      // body:  OpenStreetMapSearchAndPick(
      //           buttonColor: ColorManager.primary,
      //           buttonText: S.of(context).pickLocation,
      //           onPicked: (pickedData) {
      //             context.pop();
      //             PlaceCubit.get().pickLocation(
      //                 PlaceLocation(
      //                   latitude: pickedData.latLong.latitude,
      //                   longitude: pickedData.latLong.longitude,
      //                 ),
      //                 address: pickedData.addressName);
      //           }),
    );
  }
}
