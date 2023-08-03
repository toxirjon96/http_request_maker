class UrlException implements Exception {
  final String _message;

  const UrlException(String message) : _message = message;

  String get message => _message;
}
