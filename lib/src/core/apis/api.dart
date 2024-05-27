class ApiManager {
  static const String baseUrl = 'http://abdoo120-001-site1.ctempurl.com/api/';
  static const String webSocket = "ws://abdoo120-001-site1.ctempurl.com/api/Hub?id";
  static const String authToken = "Basic MTExNzM2NDY6NjAtZGF5ZnJlZXRyaWFs";

  static String handleImageUrl(String url) {
    return baseUrl.replaceAll("/api", "") + url.toString().replaceAll("\\", "/");
  }
}
