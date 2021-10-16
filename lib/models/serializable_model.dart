abstract class SerializableModel {
  Map<String, dynamic> toJson();
}

abstract class CacheableModel extends SerializableModel {
  String get cacheKey;
}
