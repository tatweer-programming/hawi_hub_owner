import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PickLocationScreen extends StatelessWidget {
  const PickLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit cubit = PlaceCubit.get();
    return Scaffold(
      body: FlutterLocationPicker(
          showSearchBar: false,
          initZoom: 11,
          minZoomLevel: 5,
          maxZoomLevel: 16,
          trackMyPosition: true,
          onPicked: (pickedData) {
            cubit.placeLocation = PlaceLocation(
              latitude: pickedData.latLong.latitude,
              longitude: pickedData.latLong.longitude,
            );
          }),
    );
  }
}
