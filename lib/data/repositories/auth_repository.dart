import 'package:genxshop/data/datasources/remote/auth_remote_data_source.dart';
import 'package:genxshop/data/models/login_response_model.dart';

class AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepository(this.remote);

  Future<LoginResponse> login(String email, String password) {
    return remote.login(email, password);
  }

  Future<void> register(String name, String email, String password) {
    return remote.register(name, email, password);
  }
}
