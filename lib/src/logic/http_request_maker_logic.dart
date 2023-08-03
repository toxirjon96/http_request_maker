import 'package:http_request_maker/http_request_maker_library.dart';

class HttpRequestMakerLogic {
  const HttpRequestMakerLogic();

  void call() {
    todoRequest();
  }

  void todoRequest() async {
    String baseUrl = "https://64c9fb26b2980cec85c2ab91.mockapi.io";

    try {
      HttpRequestMaker request = HttpRequestMaker(
        baseUrl: baseUrl,
        convert: TodoModel.convert(),
      );
      TodoModel? todo = await request.getRequestById("/todos/1");
      print(todo);
      print(await request.getRequest("/todos"));

      //update
      if (todo != null) {
        print(await request.updateById(
          "/todos/1",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "title": "Todo title changed",
            "description": "Todo description changed",
          }),
        ));
      }
      //print(await request.deleteById("/todos/9"));
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
