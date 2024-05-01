class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
  });

  factory PlaceLocation.fromString(String string) {
    return PlaceLocation(
      latitude: double.parse(string.split(",")[0]),
      longitude: double.parse(string.split(",")[1]),
    );
  }
  String toStr() {
    return "$latitude,$longitude";
  }
}
