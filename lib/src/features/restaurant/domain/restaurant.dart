class Restaurant {
  final String id;
  final String name;
  final double? avgFoodRating;
  final double? avgDrinksRating;
  final double? avgServiceRating;
  final double? avgAtmosphereRating;
  final bool? avgAffordability;
  final double? avgTotalScore;

  Restaurant({
    required this.id,
    required this.name,
    this.avgFoodRating,
    this.avgDrinksRating,
    this.avgServiceRating,
    this.avgAtmosphereRating,
    required this.avgAffordability,
    this.avgTotalScore,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      avgFoodRating: (json['avg_food_rating'] as num?)?.toDouble(),
      avgDrinksRating: (json['avg_drinks_rating'] as num?)?.toDouble(),
      avgServiceRating: (json['avg_service_rating'] as num?)?.toDouble(),
      avgAtmosphereRating: (json['avg_atmosphere_rating'] as num?)?.toDouble(),
      avgAffordability: json['avg_affordability'],
      avgTotalScore: (json['avg_total_score'] as num?)?.toDouble(),
    );
  }
}
