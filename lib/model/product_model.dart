import 'package:contador/model/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? 0,
    title: json['title'] ?? 'No title',
    price: (json['price'] ?? 0).toDouble(),
    description: json['description'] ?? 'No description',
    category: json['category'] ?? 'No category',
    image: json['image'] ?? 'No image',
    rating: RatingModel(
      rate: (json['rating']?['rate'] ?? 0).toDouble(),
      count: json['rating']?['count'] ?? 0,
    ),
  );
}
