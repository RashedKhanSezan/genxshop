import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';


import 'package:hive_flutter/hive_flutter.dart'; 
import 'data/models/product_model.dart'; 



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter()); 
  await Hive.openBox<ProductModel>('products_box');

  final prefs = await SharedPreferences.getInstance();
  final bool isComplete = prefs.getBool('onboardingComplete') ?? false;

  final String initialRoute =
      isComplete ? AppRoutes.login : AppRoutes.onboarding;

  runApp(GenxShop(initialRoute: initialRoute));
}


class GenxShop extends StatelessWidget {
  final String initialRoute;

  const GenxShop({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
    );
  }
}
