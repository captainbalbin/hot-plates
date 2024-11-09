import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

List<Widget> generateNavItems(
    int currentPageIndex, ValueChanged<int> onPressed) {
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
        child: SizedBox(
          height: 56,
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
                  color: currentPageIndex == index ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    },
  );

  navItems.insert(
      2,
      const SizedBox(
        width: 40,
      ));

  return navItems;
}
