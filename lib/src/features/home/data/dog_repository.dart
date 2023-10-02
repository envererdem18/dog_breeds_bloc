import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart' show AsyncMemoizer;
import 'package:dog_breeds_bloc/src/features/home/domain/breed.dart';
import 'package:flutter/services.dart' show NetworkAssetBundle;
import 'package:http/http.dart' as http;

class DogRepository {
  DogRepository({
    http.Client? httpClient,
    this.baseUrl = 'https://dog.ceo/api',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  final _fetch = AsyncMemoizer<Uint8List>();

  Future<List<Breed>> getAllBreeds() async {
    try {
      final response =
          await httpClient.get(Uri.parse('$baseUrl/breeds/list/all'));
      final results = json.decode(response.body) as Map<String, dynamic>;
      final message = results['message'] as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final breeds = <Breed>[];
        message.forEach(
          (key, value) => breeds.add(
            Breed(name: key, subBreeds: List.from(value), imagePath: ''),
          ),
        );
        return breeds;
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
        final url = data['message'];
        _setMemoizer(url);
        return url;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  ///
  /// [AsyncMemoizer] and runOnce are used to ensure that this operation is performed only once,
  /// thus providing performance and efficiency gains.
  ///
  void _setMemoizer(url) {
    _fetch.runOnce(
      () => NetworkAssetBundle(Uri.parse(url)).load(url).then(
            (byteData) => byteData.buffer.asUint8List(),
          ),
    );
  }
}
