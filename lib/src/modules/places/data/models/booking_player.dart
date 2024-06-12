class BookingPlayer {
  final int id;
  final String name;
  final String image;

  BookingPlayer({
    required this.id,
    required this.name,
    required this.image,
  });

  factory BookingPlayer.fromJson(Map<String, dynamic> json) {
    return BookingPlayer(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}


