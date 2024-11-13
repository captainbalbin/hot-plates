import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../application/rating_service.dart';

class AddRatingPage extends StatefulWidget {
  const AddRatingPage({super.key});

  @override
  State<AddRatingPage> createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  // late Future<void> _future;

  @override
  void initState() {
    super.initState();
    // var appState = context.read<RatingService>();
    // _future = appState.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<RatingService>();

    return Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //         onPressed: () => print('aaaa'), icon: Icon(Ionicons.exit))
        //   ],
        // ),
        body: Center(child: Text('rating page')));
  }
}
