import 'package:hive/hive.dart';
import '../models/product_model.dart';
import '../datasources/remote/product_remote_data_source.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  

  final Box<ProductModel> _productBox = Hive.box<ProductModel>('products_box');

  ProductRepository(this.remoteDataSource);

  Future<List<ProductModel>> getProducts(String token) async {
    try {
    
      final response = await remoteDataSource.getProducts(token);
      final List<ProductModel> products = response
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();

   
      await _productBox.clear();
      await _productBox.addAll(products); 

      return products;
    } catch (e) {
   
      if (_productBox.isNotEmpty) {
        print(" Offline Mode: Loading products from Hive cache");
        return _productBox.values.toList();
      } else {
        
        throw Exception("No internet connection and no cached data available.");
      }
    }
  }


  Future<void> addProduct(String token, Map<String, dynamic> body) async {
    await remoteDataSource.addProduct(token, body);
    await _productBox.clear(); 
  }

  Future<void> updateProduct(String token, String id, Map<String, dynamic> body) async {
    await remoteDataSource.updateProduct(token, id, body);
    await _productBox.clear();
  }

  Future<void> deleteProduct(String token, String id) async {
    await remoteDataSource.deleteProduct(token, id);
   
    final itemKey = _productBox.values.toList().indexWhere((p) => p.id == id);
    if (itemKey != -1) await _productBox.deleteAt(itemKey);
  }
}