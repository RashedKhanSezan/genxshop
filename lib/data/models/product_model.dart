import 'package:hive/hive.dart';

part 'product_model.g.dart'; 

@HiveType(typeId: 0) 
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final int stock;
  @HiveField(5)
  final String category;
  @HiveField(6)
  final String? image;
  @HiveField(7)
  final String? userId;
  @HiveField(8)
  final String brand;
  @HiveField(9)
  final bool isDiscounted;
  @HiveField(10)
  final int discountPercent;
  @HiveField(11)
  final List<String> tags;
  @HiveField(12)
  final bool isActive;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    this.image,
    this.userId,
    required this.brand,
    required this.isDiscounted,
    required this.discountPercent,
    required this.tags,
    required this.isActive,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
      image: json['image'],
      userId: json['userId'],
      brand: json['brand'] ?? '',
      isDiscounted: json['isDiscounted'] ?? false,
      discountPercent: json['discountPercent'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }
}