class Rating {
  final String id;
  final String name;
  final String createdAt;
  final String userId;
  final String restaurantId;
  final double? foodRating;
  final double? drinksRating;
  final double? serviceRating;
  final double? atmosphereRating;
  final bool? affordability;

  Rating({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.userId,
    required this.restaurantId,
    this.foodRating,
    this.drinksRating,
    this.serviceRating,
    this.atmosphereRating,
    this.affordability,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      userId: json['user_id'],
      restaurantId: json['restaurant_id'],
      foodRating: (json['food_rating'] as num?)?.toDouble(),
      drinksRating: (json['drinks_rating'] as num?)?.toDouble(),
      serviceRating: (json['service_rating'] as num?)?.toDouble(),
      atmosphereRating: (json['atmosphere_rating'] as num?)?.toDouble(),
      affordability: json['affordability'],
    );
  }
}
