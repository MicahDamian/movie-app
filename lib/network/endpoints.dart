class Endpoints {

  static const String baseUrl = "https://www.omdbapi.com/";

  static const String apiKey = "8eae8972";

  static const String searchMovies = "/";

  static String movieDetails(String imdbId) => "/?i=$imdbId";

  static const String posterBase = "https://img.omdbapi.com/";
}
