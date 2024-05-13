class Connection {
  final String id;
  final String token;

  Connection({required this.id, required this.token});

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json["connectionId"],
      token: json["connectionToken"],
    );
  }
}
