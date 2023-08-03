import 'package:http/http.dart';
import 'package:http_request_maker/http_request_maker_library.dart';
import 'package:http_request_maker/src/exception/http_request_ecxeption.dart';

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
      _checkUrl(baseUrl);
      _baseUrl = baseUrl;
    } on HttpUrlException {
      rethrow;
    }
  }

  String get baseUrl => _baseUrl;

  List<T>? Function(Map<String, Object?> json) get convertList => _convertList;

  T? Function(Map<String, Object?> json) get convert => _convert;

  Future<List<T>> getRequest(String subUrl) async {
    try {
      _checkUrl("$baseUrl$subUrl");
      Response response = await get(Uri.parse("$baseUrl$subUrl"));
      if (response.statusCode == 200) {
      } else {
        throw HttpStatusCodeException("request return ${response.statusCode}");
      }
    } on HttpUrlException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  void _checkUrl(String url) {
    try {
      Uri.parse(baseUrl);
    } catch (e) {
      throw HttpUrlException("This is not valid url");
    }
  }
}
