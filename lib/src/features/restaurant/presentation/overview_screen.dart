// File: src/features/restaurant/presentation/pages/overview_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../application/restaurant_service.dart';
import './restaurant_card.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    var appState = context.read<RestaurantService>();
    _future = appState.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<RestaurantService>();
    var restaurants = appState.restaurants;

    return FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching ratings'));
        } else if (restaurants.isEmpty) {
          return Center(child: Text('No ratings found.'));
        }

        return RefreshIndicator(
          edgeOffset: kToolbarHeight,
          onRefresh: () async {
            await appState.fetchRestaurants();
          },
          child: ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          ),
        );
      },
    );
  }
}
