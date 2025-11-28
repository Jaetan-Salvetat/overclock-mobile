import 'package:overclock/core/errors/app_errors.dart';
import 'package:overclock/core/networking/http/app_api.dart';
import 'package:overclock/core/networking/http/models/request/request_login.dart';
import 'package:overclock/core/networking/http/models/responses/response_login.dart';
import 'package:overclock/core/services/token_service.dart';

class AuthApi extends AppApi {
  Future<void> login(String key) async {
    try {
      final result = await dio.post(
        '/auth',
        data: RequestLogin(key: key).toJson(),
      );
      handleResponseError(result);
      final response = ResponseLogin.fromJson(result.data);
      TokenService.instance.setToken(key, response.token);
    } catch (e) {
      throw e is AppError ? e : AppError.unknown;
    }
  }
}
