import 'dart:convert';

class Beneficiary {
  String id;
  final String name;
  String upi;
  final int phnumber;

  Beneficiary({
    required this.id,
    required this.name,
    required this.upi,
    required this.phnumber,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'upi': upi,
        'phnumber': phnumber,
      };

  static Beneficiary fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json['id'],
        name: json['name'],
        upi: json['upi'],
        phnumber: json['phnumber'],
      );
}

final allUsers = [
  Beneficiary(
    id: '1',
    name: 'Asjad',
    upi: '9621303910@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '2',
    name: 'Asjad',
    upi: '962130391@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '3',
    name: 'Asjad',
    upi: '96213039@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '4',
    name: 'Asjad',
    upi: '962130390@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '5',
    name: 'Asjad',
    upi: '962130910@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '6',
    name: 'Asjad',
    upi: '962133910@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '7',
    name: 'Asjad',
    upi: '962303910@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '8',
    name: 'Asjad',
    upi: '961303910@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '9',
    name: 'Asjad',
    upi: '921303910@upi',
    phnumber: 9621303910,
  ),
  Beneficiary(
    id: '10',
    name: 'Asjad',
    upi: '621303910@upi',
    phnumber: 9621303910,
  ),
];
