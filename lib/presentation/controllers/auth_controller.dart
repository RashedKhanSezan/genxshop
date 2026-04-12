import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController(this.repository);

  var isLoading = false.obs;

  void login(String email, String password) async {
    try {
      isLoading(true);
      final response = await repository.login(email, password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      Get.snackbar('Success', 'Login Successful');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
