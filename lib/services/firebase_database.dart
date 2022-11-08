class Payer {
  final String name;
  final String email;

  Payer({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  static Payer fromJson(Map<String, dynamic> json) => Payer(
        name: json['name'],
        email: json['email'],
      );
}
