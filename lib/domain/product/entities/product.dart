import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? name;

  /// [item,box]
  String? unitType;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    required this.unitType,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.empty() => Product(
      name: '',
      unitType: null,
      price: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Product.fromMap(doc.data()!).copyWith(id: doc.id);
  }

  Product copyWith({
    String? id,
    String? name,
    String? unitType,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      unitType: unitType ?? this.unitType,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unitType': unitType,
      'price': price,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      unitType: map['unitType'],
      price: map['price'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
