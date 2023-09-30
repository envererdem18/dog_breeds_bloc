class Breed {
  final String name;
  final String imagePath;
  Breed({
    required this.name,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breed && other.name == name && other.imagePath == imagePath;
  }

  @override
  int get hashCode => name.hashCode ^ imagePath.hashCode;
}
