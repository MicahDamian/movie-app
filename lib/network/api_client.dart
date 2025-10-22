import 'dart:convert';
import 'package:http/http.dart' as http;
import 'endpoints.dart';

class ApiClient {
  final http.Client _httpClient;

  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? params}) async {
    final uri = Uri.parse("${Endpoints.baseUrl}$endpoint").replace(
      queryParameters: {
        "apikey": Endpoints.apiKey,
        ...?params,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }

  void close() {
    _httpClient.close();
  }
}