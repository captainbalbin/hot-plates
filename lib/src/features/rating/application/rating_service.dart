import 'package:flutter/material.dart';
import '../data/rating_repository.dart';
import '../domain/rating.dart';

class RatingService extends ChangeNotifier {
  final RatingRepository _repository = RatingRepository();

  Future<void> addRating(Rating rating) async {
    try {
      rating = (await _repository.addRating(rating)) as Rating;
      notifyListeners();
    } catch (e) {
      print("Error adding rating: $e");
    }
  }
}
