import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';

class PlaceLocation extends StatelessWidget {
  final PlaceLocation location;
  const PlaceLocation({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).location),
      ),
      body: FlutterMap(options: MapOptions(), children: []),
    );
  }
}
