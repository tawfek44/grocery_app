import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:grocery_app/screens/home_screen/view/ui_components/ui_components.dart';
import 'package:grocery_app/utils/colors/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DashboardController.dashboardController().getSumInCart();
    return GetBuilder<DashboardController>(builder: (controller){
      return Scaffold(
        body: controller.screens[controller.selectedItem],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {  },
          backgroundColor: mainColor,
          label: GetBuilder<DashboardController>
            (
              builder: (controller){
               print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
               print(controller.sumInCart.toString());
               return Text('\$ ${controller.sumInCart.toString()}');
             },
          ),
          icon: const Icon(Icons.add_shopping_cart_rounded),
          ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedItem,
          onTap:controller.changeItemSelection,
          selectedItemColor: HexColor('#d93e11'),
          unselectedItemColor: HexColor('#949494'),
          items: buttonNavigationBarSection(),

        ),
      );
    });
  }

}
