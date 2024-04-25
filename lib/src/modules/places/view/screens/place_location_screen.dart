import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PlaceLocationScreen extends StatelessWidget {
  final PlaceLocation location;
  const PlaceLocationScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).location),
      ),
      body: FlutterLocationPicker(
        onPicked: (PickedData pickedData) {},
        showSearchBar: false,
        showSelectLocationButton: false,
        showZoomController: false,
        showLocationController: false,
        loadingWidget: CircularProgressIndicator(),
        showCurrentLocationPointer: false,
        showContributorBadgeForOSM: false,
        initPosition: LatLong(location.latitude, location.longitude),
      ),
    );
  }
}
