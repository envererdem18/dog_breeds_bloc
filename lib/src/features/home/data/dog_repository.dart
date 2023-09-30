import 'dart:convert';

import 'package:dog_breeds_bloc/src/features/home/data/get_all_breeds_response.dart';
import 'package:http/http.dart' as http;

class DogRepository {
  DogRepository({
    http.Client? httpClient,
    this.baseUrl = 'https://dog.ceo/api',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<GetAllBreedsResponse> getAllBreeds() async {
    try {
      final response =
          await httpClient.get(Uri.parse('$baseUrl/breeds/list/all'));
      final results = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return GetAllBreedsResponse.fromMap(results);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<String> generate({required String breed}) async {
    try {
      final response = await httpClient
          .get(Uri.parse('$baseUrl/breed/$breed/images/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
