import 'dart:convert';

class Usera {
  final String name;
  final String email;

  Usera({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  static Usera fromJson(Map<String, dynamic> json) => Usera(
        name: json['name'],
        email: json['email'],
      );
}
