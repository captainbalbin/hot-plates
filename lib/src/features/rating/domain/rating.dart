class Rating {
  final String name;
  final String userId;
  final String restaurantId;
  final double foodRating;
  final double drinksRating;
  final double serviceRating;
  final double atmosphereRating;
  final bool affordability;

  Rating({
    required this.name,
    required this.userId,
    required this.restaurantId,
    required this.foodRating,
    required this.drinksRating,
    required this.serviceRating,
    required this.atmosphereRating,
    required this.affordability,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      name: json['name'],
      userId: json['user_id'],
      restaurantId: json['restaurant_id'],
      foodRating: (json['food_rating'] as num?)!.toDouble(),
      drinksRating: (json['drinks_rating'] as num?)!.toDouble(),
      serviceRating: (json['service_rating'] as num?)!.toDouble(),
      atmosphereRating: (json['atmosphere_rating'] as num?)!.toDouble(),
      affordability: json['affordability'],
    );
  }
}
