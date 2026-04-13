import 'package:genxshop/presentation/pages/product_form_page.dart';
import 'package:genxshop/presentation/pages/product_view_page.dart';
import 'package:get/get.dart';

import '../presentation/pages/onboarding_page.dart';
import '../presentation/bindings/onboarding_binding.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/register_page.dart';
import '../presentation/pages/verify_otp_page.dart';
import '../presentation/pages/product_list_page.dart';


import '../presentation/bindings/auth_binding.dart';
import '../presentation/bindings/product_binding.dart';


import './app_routes.dart';

class AppPages {
  static final pages = [

    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(), 
    ),

  
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
  
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),

    
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),

  
    GetPage(
      name: AppRoutes.verify,
      page: () => const VerifyOtpPage(),
      binding: AuthBinding(),
    ),

   
    GetPage(
      name: AppRoutes.product,
      page: () => const ProductListPage(),
      binding: ProductBinding(),
    ),

    GetPage(
      name: AppRoutes.productForm,
      page: () => const ProductFormPage(),
    ),


    GetPage(
      name: AppRoutes.productViewPage,
      page: () => const ProductViewPage(),
    ),
  ];
}
