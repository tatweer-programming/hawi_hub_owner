class AppNotification {
  final String title;
  final String body;
  final String? image;
  final String? link;
  final DateTime? dateTime;
  AppNotification(this.dateTime, {required this.title, required this.body, this.image, this.link});

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      DateTime.tryParse(json['date_time']),
      title: json['title'],
      body: json['body'],
      image: json['image'],
      link: json['link'],
    );
  }
}
