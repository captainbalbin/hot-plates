import 'package:flutter/material.dart';
import '../domain/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    restaurant.avgTotalScore?.toStringAsFixed(2) ?? '-',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                  'Food: ${restaurant.avgFoodRating?.toStringAsFixed(2) ?? '-'}'),
              Text(
                  'Drinks: ${restaurant.avgDrinksRating?.toStringAsFixed(2) ?? '-'}'),
              Text(
                  'Service: ${restaurant.avgServiceRating?.toStringAsFixed(2) ?? '-'}'),
              Text(
                  'Atmosphere: ${restaurant.avgAtmosphereRating?.toStringAsFixed(2) ?? '-'}'),
              Text(
                  'Affordability: ${restaurant.avgAffordability == null ? '-' : (restaurant.avgAffordability! ? 'Affordable' : 'Expensive')}'),
            ],
          ),
        ),
      ),
    );
  }
}
