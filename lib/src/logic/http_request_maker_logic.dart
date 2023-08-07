import 'package:http_request_maker/http_request_maker_library.dart';

class HttpRequestMakerLogic {
  const HttpRequestMakerLogic();

  void call() {
    String baseUrl = "https://64c9fb26b2980cec85c2ab91.mockapi.io";

    //todoRequest(baseUrl);
    usersRequest(baseUrl);
  }

  void todoRequest(String baseUrl) async {
    try {
      HttpRequestMaker request = HttpRequestMaker(
        baseUrl: baseUrl,
        convert: TodoModel.convert(),
      );

      print(await request.getRequestById("/todos/1"));
      print(await request.getRequest("/todos"));
      //update
      print(await request.updateById(
        "/todos/1",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": "Todo title changed",
          "description": "Todo description changed",
        }),
      ));

      //post
      print(await request.postRequest(
        "/todos",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "title": "Todo title created",
          "description": "Todo description created"
        }),
      ));
      print(await request.deleteById("/todos/12"));
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

  void usersRequest(String baseUrl) async {
    try {
      HttpRequestMaker request = HttpRequestMaker(
        baseUrl: baseUrl,
        convert: Users.convert(),
      );

      print(await request.getRequestById("/users/1"));
      print(await request.getRequest("/users"));
      //update
      print(await request.updateById(
        "/users/1",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": "John Wick",
        }),
      ));

      print(await request.updateById(
        "/users/2",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": "Jack Wall",
        }),
      ));

      //post
      print(await request.postRequest(
        "/users",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "name": "Gupta",
          "country": "India",
          "email": "gupta@gmail.com",
          "phone": "+78988888818",
          "createdAt": "${DateTime.now()}",
        }),
      ));
      print(await request.postRequest(
        "/users",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "name": "Raj Kapoor",
          "country": "India",
          "email": "kapoor@gmail.com",
          "phone": "+78988888818",
          "createdAt": "${DateTime.now()}",
        }),
      ));
      //print(await request.deleteById("/users/12"));
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
