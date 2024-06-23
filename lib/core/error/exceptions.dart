/// Exception thrown when a server error occurs.
class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

/// Exception thrown when a cache error occurs.
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}
