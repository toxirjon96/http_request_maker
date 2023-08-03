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

  Future<List<T?>?> getRequest(String subUrl,
      {Map<String, String>? headers}) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await get(
        Uri.parse(url),
        headers: headers,
      );
      _statusCodeException(response, 200);
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

  Future<T?> postRequest(
    String subUrl, {
    Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);

      Response response = await post(
        Uri.parse(url),
        body: body,
        encoding: encoding,
        headers: headers,
      );
      _statusCodeException(response, 201);
      return _getObject(response.body);
    } on HttpUrlException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Future<T?> getRequestById(String subUrl,
      {Map<String, String>? headers}) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await get(
        Uri.parse(url),
        headers: headers,
      );
      _statusCodeException(response, 200);
      return _getObject(response.body);
    } on HttpUrlException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Future<T?> deleteById(
    String subUrl, {
    Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await delete(
        Uri.parse(url),
        body: body,
        encoding: encoding,
        headers: headers,
      );
      _statusCodeException(response, 200);
      return _getObject(response.body);
    } on HttpUrlException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Future<T?> updateById(
    String subUrl, {
    Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await put(
        Uri.parse(url),
        body: body,
        encoding: encoding,
        headers: headers,
      );
      _statusCodeException(response, 200);
      return _getObject(response.body);
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

  void _statusCodeException(Response response, int statuscode) {
    if (response.statusCode != statuscode) {
      throw HttpStatusCodeException("Request returns ${response.statusCode}.");
    }
  }
}
