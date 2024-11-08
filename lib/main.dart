import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.dark,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  List<Map<String, dynamic>> restaurants = [];

  Future<void> fetchRestaurants() async {
    try {
      final restaurantsRes =
          await supabase.from('restaurants_with_ratings').select();

      print("restaurants: $restaurantsRes");

      restaurants = List<Map<String, dynamic>>.from(restaurantsRes);
      notifyListeners();
    } catch (e) {
      print("Error fetching ratings: $e");
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (value) {
                print('selected: $value');
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatefulWidget {
  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    var appState = context.read<MyAppState>();
    _future = appState.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Error in FutureBuilder: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            var restaurants = appState.restaurants;

            print('Restaurants: $restaurants');

            if (restaurants.isEmpty) {
              return Center(child: Text('No ratings found.'));
            }

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = restaurants[index];
                print('*** Restaurant: $restaurant');

                var ratings = restaurant['ratings'] as List<dynamic>? ?? [];

                print('*** Ratings: $ratings');

                return ListTile(
                  title: Text(restaurant['name'] ?? 'No name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ratings.map<Widget>((rating) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Food: ${rating['food_rating']}'),
                            Text('Drinks: ${rating['drinks_rating']}'),
                            Text('Service: ${rating['service_rating']}'),
                            Text('Atmosphere: ${rating['atmosphere_rating']}'),
                            Text('Affordability: ${rating['affordability']}'),
                            Text('Score: ${rating['total_score']}'),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
