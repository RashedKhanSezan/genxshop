import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController(this.repository);


  var isLoading = false.obs;


  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await repository.login(email, password);


      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      print("✅ TOKEN SAVED: ${response.token}");

      Get.snackbar('Success', 'Login Successful');

    
      Get.offAllNamed('/product');
    } catch (e) {
      print("LOGIN ERROR: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      print(" REGISTER START");

      isLoading.value = true;

      await repository.register(name, email, password);

      print("REGISTER SUCCESS");

      Get.snackbar("Success", "Registration Successful");
    } catch (e) {
      print(" REGISTER ERROR: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Get.snackbar("Logout", "Logged out successfully");

    
  }
}
