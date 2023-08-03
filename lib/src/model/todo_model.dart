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

  @override
  String toString() {
    return "$runtimeType{id: $id, title: $title, description:$description}";
  }
}
