class Users {
  String? id;
  String? name;
  String? country;
  String? email;
  String? phone;
  String? createdAt;

  Users({
    this.id,
    this.name,
    this.country,
    this.email,
    this.phone,
    this.createdAt,
  });

  factory Users.fromJson(Map<String, Object?> json) {
    return Users(
      id: json["id"] as String?,
      name: json["name"] as String?,
      country: json["country"] as String?,
      email: json["email"] as String?,
      phone: json["phone"] as String?,
      createdAt: json["createdAt"] as String?,
    );
  }

  static Users Function(Map<String, Object?> json) convert() =>
      (Map<String, Object?> json) {
        return Users.fromJson(json);
      };

  @override
  String toString() {
    return "$runtimeType{id: $id, name: $name, country: $country,"
        " email: $email, phone: $phone, createdAt: $createdAt,}";
  }
}
