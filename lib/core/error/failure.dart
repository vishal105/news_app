/// Abstract class representing a failure.
abstract class Failure {
  final String message;

  Failure(this.message);
}

/// Represents a server failure.
class ServerFailure extends Failure {
  ServerFailure(super.message);
}

/// Represents a cache failure.
class CacheFailure extends Failure {
  CacheFailure(super.message);
}
