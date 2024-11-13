import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../application/rating_service.dart';
import '../domain/rating.dart';

class AddRatingPage extends StatefulWidget {
  const AddRatingPage({super.key});

  @override
  State<AddRatingPage> createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  final _formKey = GlobalKey<FormState>();
  double? _foodRating;
  double? _drinksRating;
  double? _serviceRating;
  double? _atmosphereRating;
  bool? _affordability;

  void _submitRating() {
    if (_formKey.currentState!.validate()) {
      if (_foodRating == null ||
          _drinksRating == null ||
          _serviceRating == null ||
          _atmosphereRating == null) {
        return;
      }
      print('*** Saving rating');
      _formKey.currentState?.save();
      final rating = Rating(
        name: 'Sample Rating',
        userId: 'sampleUserId',
        restaurantId: 'sampleRestaurantId',
        foodRating: _foodRating!,
        drinksRating: _drinksRating!,
        serviceRating: _serviceRating!,
        atmosphereRating: _atmosphereRating!,
        affordability: _affordability!,
      );
      print('*** Rating: $rating');
      context.read<RatingService>().addRating(rating);
      Navigator.of(context).pop();
    } else {
      print('*** Rating invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var children = [
    //   Text('Food Rating'),
    //   Slider(
    //     value: _foodRating ?? 0.0,
    //     min: 0,
    //     max: 5,
    //     divisions: 20,
    //     label: _foodRating.toString(),
    //     onChanged: (value) {
    //       setState(() {
    //         _foodRating = value;
    //       });
    //     },
    //     onChangeEnd: (value) {
    //       _foodRating = value;
    //     },
    //   ),
    //   ElevatedButton(
    //     onPressed: _submitRating,
    //     child: Text('Submit Rating'),
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Ionicons.close)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: ListView(
            children: buildRatingSliders(['a', 'b', 'c', 'd'], setState),
          ),
        ),
      ),
    );
  }
}

List<Widget> buildRatingSliders(List<String> options, onRatingChanged) {
  return options.map((option) {
    double? rating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$option Rating'),
        Slider(
          value: rating ?? 0.0,
          min: 0,
          max: 5,
          divisions: 20,
          label: rating?.toString(),
          onChanged: (value) {
            onRatingChanged(() {
              rating = value;
            });
          },
          onChangeEnd: (value) {
            rating = value;
          },
        ),
      ],
    );
  }).toList();
}
