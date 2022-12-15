import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/cart_screen/view/cart_screen.dart';
import 'package:grocery_app/screens/dashboard/view/dashboard.dart';
import 'package:grocery_app/screens/favourite_screen/view/favourite_screen.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:grocery_app/screens/news_screen/view/news_screen.dart';

import '../../cart_screen/controller/cart_controller.dart';
import '../../home_screen/view/home_screen.dart';

class DashboardController extends GetxController{
  static DashboardController dashboardController()=>Get.find<DashboardController>();
  int selectedItem = 0;
  List<Widget> screens= const[
     HomeScreen(),
     NewsScreen(),
     FavouriteScreen(),
     CartScreen()
  ];
  void changeItemSelection(index){
    selectedItem=index;
    update();
  }
  double sumInCart=0;
  void getSumInCart(){
    sumInCart=0;
    for(int i=0;i<CartController.cartController().quantities.length;i++){
      if(HomeController.homeController().productList[i].offer!=null){
        sumInCart+= HomeController.homeController().productList[i].offer!;
      }
      else{
        sumInCart+= HomeController.homeController().productList[i].price;
      }

    }
    update();
  }

}