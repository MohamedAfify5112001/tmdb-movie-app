import 'dart:io';

import 'package:dio/dio.dart';

import '../../utils/app_constants.dart';

class DioHelper {
  static late Dio dio;

  static initDio() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: AppConstants.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
  }

  static Future<Response> getData({required String path}) async {
    return await dio
        .get(path, queryParameters: {'api_key': AppConstants.myKey});
  }
}
