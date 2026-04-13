import 'package:genxshop/data/datasources/remote/product_remote_data_source.dart';
import 'package:get/get.dart';
import '../../data/repositories/product_repository.dart';
import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductRemoteDataSource());
    Get.lazyPut(() => ProductRepository(Get.find()));
    Get.lazyPut(() => ProductController(Get.find()));
  }
}
