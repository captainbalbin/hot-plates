import 'package:flutter/material.dart';
import '../data/restaurant_repository.dart';
import '../domain/restaurant.dart';

class RestaurantService extends ChangeNotifier {
  final RestaurantRepository _repository = RestaurantRepository();
  List<Restaurant> restaurants = [];

  Future<void> fetchRestaurants() async {
    try {
      restaurants = await _repository.getRestaurants();
      notifyListeners();
    } catch (e) {
      print("Error fetching restaurants: $e");
    }
  }
}
