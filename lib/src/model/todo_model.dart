class TodoModel {
  String? id;
  String? title;
  String? description;

  TodoModel({
    this.id,
    this.title,
    this.description,
  });

  factory TodoModel.fromJson(Map<String, Object?> json) {
    return TodoModel(
      id: json["id"] as String?,
      title: json["title"] as String?,
      description: json["description"] as String?,
    );
  }

  static TodoModel Function(Map<String, Object?> json) convert() =>
      (Map<String, Object?> json) {
        return TodoModel.fromJson(json);
      };

  static List<TodoModel> Function(Map<String, Object?> map) convertList() =>
      (Map<String, Object?> map) {
        List<TodoModel>? todoList = [];
        List<Object?> list = map["todos"] as List<Object?>;

        todoList = list
            .map((e) {
              if (e is Map<String, Object?>) {
                return convert()(e);
              }
            })
            .cast<TodoModel>()
            .toList();
        return todoList;
      };

  @override
  String toString() {
    return "$runtimeType{id: $id, title: $title, description:$description}";
  }
}
