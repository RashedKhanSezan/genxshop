import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;

  ProductController(this.repository);

  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception("Token not found");
    }
    return token;
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final token = await _getToken();
      final products = await repository.getProducts(token);
      productList.value = products;
    } catch (e) {
      Get.snackbar("Error", "Failed to load products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct(Map<String, dynamic> body) async {
    try {
      isLoading.value = true;
      final token = await _getToken();

      await repository.addProduct(token, body);
      Get.snackbar("Success", "Product created successfully");

      await fetchProducts();
      Get.back();
    } catch (e) {
      Get.snackbar("Add Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(String id, Map<String, dynamic> body) async {
    try {
      isLoading.value = true;
      final token = await _getToken();

      await repository.updateProduct(token, id, body);

      Get.snackbar("Success", "Product updated successfully");

      await fetchProducts();
      Get.back();
    } catch (e) {
      print("UPDATE ERROR: $e");
      Get.snackbar("Error", "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      isLoading.value = true;
      final token = await _getToken();

      await repository.deleteProduct(token, id);

      Get.snackbar("Deleted", "Product removed successfully",
          snackPosition: SnackPosition.BOTTOM);

      await fetchProducts();
      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
