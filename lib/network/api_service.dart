import 'package:movie_app/network/api_client.dart';
import '../models/movie.dart';

/// Interface defining what API methods are available
abstract class ApiService {
  Future<List<Movie>> searchMovies(String title);
}

/// Implementation of the ApiService using ApiClient
class ApiServiceImpl implements ApiService {
  final ApiClient _apiClient;

  ApiServiceImpl(this._apiClient);

  @override
  Future<List<Movie>> searchMovies(String title) async {
    final response = await _apiClient.get("", params: {
      "s": title, // OMDb search parameter
      "type": "movie",
    });

    if (response["Response"] == "True") {
      final List results = response["Search"];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
