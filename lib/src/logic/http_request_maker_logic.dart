import 'package:http_request_maker/http_request_maker_library.dart';

class HttpRequestMakerLogic {
  const HttpRequestMakerLogic();

  void call() {
    todoRequest();
  }

  void todoRequest() {
    String baseUrl = "https://64c9fb26b2980cec85c2ab91.mockapi.io";

    try {
      HttpRequestMaker request = HttpRequestMaker(
        baseUrl: baseUrl,
        convertList: TodoModel.convertList(),
        convert: TodoModel.convert(),
      );
      print(request.getRequestById("/todos/8"));
    } on HttpUrlException catch (e) {
      print(e.message);
    } on JsonDecodeException catch (e) {
      print(e.message);
    } on HttpStatusCodeException catch (e) {
      print(e.message);
    } on HttpRequstException catch (e) {
      print(e.message);
    }
  }
}
