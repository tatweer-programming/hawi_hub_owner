class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
  });

  static PlaceLocation? fromString(String string) {
    List<String> parts = string.split(",");
    double? lat = double.tryParse(parts[0]);
    double? long = double.tryParse(parts[1]);
    if (parts.length == 2) {
      if (lat != null && long != null) {
        return PlaceLocation(latitude: lat, longitude: long);
      }
    }
 return null;
  }

  String toStr() {
    return "$latitude,$longitude";
  }
}
