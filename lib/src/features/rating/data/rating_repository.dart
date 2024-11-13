import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/rating.dart';

class RatingRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<Rating?> addRating(Rating rating) async {
    try {
      final List<dynamic> data =
          await supabase.from('ratings').insert(rating).select();

      print("*** data: $data");

      return Rating.fromJson(Map<String, dynamic>.from(data.first));
    } catch (e) {
      print("Error fetching ratings: $e");
      return null;
    }
  }
}
