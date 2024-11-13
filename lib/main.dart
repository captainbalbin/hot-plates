import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_plates/src/features/rating/presentation/add_rating.dart';
import 'package:hot_plates/src/shared/nav_items.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/features/restaurant/application/restaurant_service.dart';
import 'src/features/restaurant/presentation/overview_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => RestaurantService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Ratings',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
            primary: Colors.black,
            secondary: Colors.deepPurpleAccent,
            surface: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardTheme(
          color: Colors.grey[200],
          shadowColor: Colors.transparent,
        ),
        appBarTheme: AppBarTheme(),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
        cardTheme: CardTheme(
          color: Colors.black,
          shadowColor: Colors.transparent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    OverviewPage(),
    Text('Favorites Page'),
    Text('Profile Page'),
    Text('Settings Page'),
    AddRatingPage(),
  ];

  void onPressed(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text('Restaurant Ratings'),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(200),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Ionicons.swap_vertical),
            onPressed: () {
              print('Sort button pressed');
            },
          ),
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {
              print('Search button pressed');
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentPageIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: generateNavItems(context, _currentPageIndex, onPressed),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            enableDrag: true,
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            builder: (context) =>
                FractionallySizedBox(heightFactor: 0.8, child: AddRatingPage()),
          );
        },
        child: Icon(Ionicons.add),
      ),
    );
  }
}
