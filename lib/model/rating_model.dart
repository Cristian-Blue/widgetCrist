class RatingModel {
  final double rate;
  final int count;

  const RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(rate: json['rate'] ?? 0, count: json['count'] ?? 0);
}
