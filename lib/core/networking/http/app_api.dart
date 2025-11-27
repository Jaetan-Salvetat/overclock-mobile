import 'package:dio/dio.dart';
import 'package:overclock/core/errors/app_errors.dart';
import 'package:overclock/core/networking/http/models/responses/response_error.dart';

abstract class AppApi {
  late final Dio dio;

  AppApi() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.overclock.jaetan.fr',
        validateStatus: (status) => true,
      ),
    );
  }

  void handleResponseError(Response response) {
    print("on handleResponseError: $response");
    if (ResponseError.isAnError(response.data)) {
      final error = ResponseError.fromJson(response.data);
      throw AppError.fromString(error.data);
    }
  }
}
