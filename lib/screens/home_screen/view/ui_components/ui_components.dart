import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants_ui_components/bottom_nav_bar.dart';

List<BottomNavigationBarItem> buttonNavigationBarSection(){
  return [
    BottomNavBarComponent().getBottomNavBar(icon: const Icon(CupertinoIcons.home), label: "Grocery"),
    BottomNavBarComponent().getBottomNavBar(icon: const Icon(CupertinoIcons.bell), label: "News"),
    BottomNavBarComponent().getBottomNavBar(icon: const Icon(Icons.favorite_border), label: "Favourite"),
    BottomNavBarComponent().getBottomNavBar(icon: const Icon(Icons.shopping_cart), label: "Cart"),

  ];
}