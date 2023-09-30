import 'dart:convert';

class GetAllBreedsResponse {
  Map<String, List<String>> message;
  String status;

  GetAllBreedsResponse({
    required this.message,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'message': message});
    result.addAll({'status': status});

    return result;
  }

  factory GetAllBreedsResponse.fromMap(Map<String, dynamic> map) {
    return GetAllBreedsResponse(
      message: Map.from(map["message"]).map((k, v) =>
          MapEntry<String, List<String>>(
              k, List<String>.from(v.map((x) => x)))),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllBreedsResponse.fromJson(String source) =>
      GetAllBreedsResponse.fromMap(json.decode(source));
}
