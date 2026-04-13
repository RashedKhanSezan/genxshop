import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  final String baseUrl = "https://product-management-seven-xi.vercel.app";

  Future<List<dynamic>> getProducts(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/products'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['data'];
    } else {
      throw Exception('Failed to load products');
    }
  }

  
  Future<void> addProduct(String token, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/products'),
      headers: {
        'Content-Type': 'application/json', 
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body), 
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print("SERVER ERROR: ${response.body}");
      throw Exception('Failed to add product');
    }
  }

  Future<void> updateProduct(
      String token, String id, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/v1/products/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Update failed: ${response.body}');
    }
  }

  Future<void> deleteProduct(String token, String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/v1/products/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }
}
