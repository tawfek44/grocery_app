import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grocery_app/screens/dashboard/view/dashboard.dart';
import 'package:grocery_app/screens/home_screen/view/home_screen.dart';
import 'package:grocery_app/utils/binding_class.dart';
import 'package:grocery_app/utils/colors/colors.dart';
import 'package:grocery_app/utils/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/dashboard",
      initialBinding: BindingClass(),
      getPages: [
        GetPage(name: "/dashboard", page: () => const DashboardScreen()),
      ],
    );
  }

}
