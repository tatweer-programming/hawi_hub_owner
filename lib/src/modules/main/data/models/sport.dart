class Sport {
  int id;
  String name;
  String image;
  Sport({required this.id, required this.name, required this.image});

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
