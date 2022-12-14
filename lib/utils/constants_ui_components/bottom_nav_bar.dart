import 'package:flutter/material.dart';

 class BottomNavBarComponent{

   BottomNavigationBarItem getBottomNavBar({
  required Widget icon,
  required String label,
}){
    return BottomNavigationBarItem(
        icon: icon,
        label: label
    );
  }
}