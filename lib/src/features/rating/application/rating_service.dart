import 'package:flutter/material.dart';
import '../data/rating_repository.dart';
import '../domain/rating.dart';

class RatingService extends ChangeNotifier {
  final RatingRepository _repository = RatingRepository();
  Rating? rating;

  Future<void> fetchRestaurants() async {
    try {
      if (rating != null) {
        rating = await _repository.addRating(rating!);
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching restaurants: $e");
    }
  }
}
