import 'package:http_request_maker/http_request_maker_library.dart';

class HttpRequestMaker<T> {
  late final String _baseUrl;
  late final T? Function(Map<String, Object?> json) _convert;

  HttpRequestMaker({
    required String baseUrl,
    required T? Function(Map<String, Object?> json) convert,
  }) {
    this.baseUrl = baseUrl;
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

  T? Function(Map<String, Object?> json) get convert => _convert;

  Future<List<T?>?> getRequest(String subUrl) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await get(Uri.parse(url));
      _statusCodeException(response);
      return _getElements(response.body);
    } on HttpUrlException {
      rethrow;
    } on JsonDecodeException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Future<T?> getRequestById(String subUrl) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await get(Uri.parse(url));
      _statusCodeException(response);
      return _getObject(response.body);
    } on HttpUrlException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Future<void> deleteById(String subUrl) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await delete(Uri.parse(url));
      print(response.body);
      _statusCodeException(response);
    } on HttpUrlException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Map<String, Object?> _jsonMap(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      throw JsonDecodeException("This is not valid format of json.");
    }
  }

  List<Object?> _jsonStringList(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      throw JsonDecodeException("This is not valid format of json.");
    }
  }

  List<Map<String, Object?>> _jsonMapList(String jsonString) {
    try {
      List<Object?> jsonStringList = _jsonStringList(jsonString);
      return jsonStringList.whereType<Map<String, Object?>>().toList();
    } on JsonDecodeException {
      rethrow;
    }
  }

  List<T?>? _getElements(String jsonString) {
    try {
      List<Map<String, Object?>> jsonMap = _jsonMapList(jsonString);
      return jsonMap.map((e) {
        return convert(e);
      }).toList();
    } on JsonDecodeException {
      rethrow;
    }
  }

  T? _getObject(String jsonString) {
    try {
      Map<String, Object?>? jsonMap = _jsonMap(jsonString);
      return convert(jsonMap);
    } on JsonDecodeException {
      rethrow;
    }
  }

  void _checkUrl(String url) {
    try {
      Uri.parse(url);
    } catch (e) {
      throw HttpUrlException("This is not valid url.");
    }
  }

  void _statusCodeException(Response response) {
    if (response.statusCode != 200) {
      throw HttpStatusCodeException("Request returns ${response.statusCode}.");
    }
  }
}
