import 'package:http_request_maker/src/exception/url_exception.dart';

class HttpRequestMaker<T> {
  late final String _baseUrl;
  late final List<T>? Function(Map<String, Object?> json) _convertList;
  late final T? Function(Map<String, Object?> json) _convert;

  HttpRequestMaker({
    required String baseUrl,
    required List<T>? Function(Map<String, Object?> json) convertList,
    required T? Function(Map<String, Object?> json) convert,
  }) {
    this.baseUrl = baseUrl;
    _convertList = convertList;
    _convert = convert;
  }

  set baseUrl(String baseUrl) {
    try {
      Uri.parse(baseUrl);
      _baseUrl = baseUrl;
    } catch (e) {
      throw UrlException("This is not valid url");
    }
  }

  String get baseUrl => _baseUrl;

  List<T>? Function(Map<String, Object?> json) get convertList => _convertList;

  T? Function(Map<String, Object?> json) get convert => _convert;
}
