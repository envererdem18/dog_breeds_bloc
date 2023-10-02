import 'package:flutter/foundation.dart';

class Breed {
  final String name;
  final List<String> subBreeds;
  final String imagePath;
  Breed({
    required this.name,
    required this.subBreeds,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breed &&
        other.name == name &&
        listEquals(other.subBreeds, subBreeds) &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode => name.hashCode ^ subBreeds.hashCode ^ imagePath.hashCode;
}
