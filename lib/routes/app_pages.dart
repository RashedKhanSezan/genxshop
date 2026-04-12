import 'package:get/get.dart';
import './app_routes.dart';
import '../presentation/pages/login_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    )
  ];
}
