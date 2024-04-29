class User {
  final int? userId;
  final String? name;


  User({
    this.userId,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: (json['userId'] as num).toInt(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
    };
  }
}
