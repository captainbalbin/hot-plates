import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

List<Widget> generateNavItems(
    BuildContext context, int currentPageIndex, Function(int) onPressed) {
  const iconMap = {
    0: Ionicons.restaurant,
    1: Ionicons.heart,
    2: Ionicons.person,
    3: Ionicons.settings,
  };

  const iconOutlineMap = {
    0: Ionicons.restaurant_outline,
    1: Ionicons.heart_outline,
    2: Ionicons.person_outline,
    3: Ionicons.settings_outline,
  };

  const navTextMap = {
    0: 'Restaurants',
    1: 'Favorites',
    2: 'Profile',
    3: 'Settings',
  };

  List<Widget> navItems = List.generate(
    4,
    (index) {
      return Expanded(
        child: GestureDetector(
          onTap: () => onPressed(index),
          child: Container(
            height: 56,
            color: Colors.transparent, // Ensure the container is transparent
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  currentPageIndex == index
                      ? iconMap[index]
                      : iconOutlineMap[index],
                ),
                Text(
                  navTextMap[index].toString(),
                  style: TextStyle(
                    color: currentPageIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  navItems.insert(
    2,
    const SizedBox(
      width: 40,
    ),
  );

  return navItems;
}
