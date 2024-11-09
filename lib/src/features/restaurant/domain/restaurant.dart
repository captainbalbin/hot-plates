class Restaurant {
  final String id;
  final String name;
  final double avgFoodRating;
  final double avgDrinksRating;
  final double avgServiceRating;
  final double avgAtmosphereRating;
  final bool avgAffordability;
  final double avgTotalScore;

  Restaurant({
    required this.id,
    required this.name,
    required this.avgFoodRating,
    required this.avgDrinksRating,
    required this.avgServiceRating,
    required this.avgAtmosphereRating,
    required this.avgAffordability,
    required this.avgTotalScore,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      avgFoodRating: (json['avg_food_rating'] as num?)?.toDouble() ?? 0.0,
      avgDrinksRating: (json['avg_drinks_rating'] as num?)?.toDouble() ?? 0.0,
      avgServiceRating: (json['avg_service_rating'] as num?)?.toDouble() ?? 0.0,
      avgAtmosphereRating:
          (json['avg_atmosphere_rating'] as num?)?.toDouble() ?? 0.0,
      avgAffordability: json['avg_affordability'] ?? false,
      avgTotalScore: (json['avg_total_score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
