import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/restaurant.dart';

class RestaurantRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Restaurant>> getRestaurants() async {
    try {
      final List<dynamic> data =
          await supabase.from('restaurant_ratings').select();

      print("*** data: $data");

      return data
          .map((item) => Restaurant.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      print("Error fetching ratings: $e");
      return [];
    }
  }
}
