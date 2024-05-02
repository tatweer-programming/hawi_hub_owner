class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
  });

  static PlaceLocation? fromString(String string) {
    List<String> parts = string.split(",");
    if (parts.length == 2) {
      double? latitude = double.tryParse(parts[0]);
      double? longitude = double.tryParse(parts[1]);
      if (latitude == null || longitude == null) {
        return null;
      }
    }
    return null;
  }

  String toStr() {
    return "$latitude,$longitude";
  }
}
