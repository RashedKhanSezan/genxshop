import 'package:get/get.dart';

import '../../data/datasources/remote/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRemoteDataSource());
    Get.lazyPut(() => AuthRepository(Get.find()));
    Get.lazyPut(() => AuthController(Get.find()));
  }
}