class Sport {
  final String name;
  final int id;
  final String image;

  Sport({
    required this.name,
    required this.id,
    required this.image,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
