import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://memorization.hophearts.com/api/',
        receiveDataWhenStatusError: true,
        headers: {},
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    dynamic query,
    String? token,
  }) async {
    dio!.options.headers = {
      'X-API-Uuid': '0678c71e-4096-464f-9b11-9ff147cd6282',
      'X-API-Key': '6cMSTnR6-eCBr-cTnA-yZS0-LljrbUaD1tmF',
      'X-API-Secret': 'SOx1G29U-Nem5-wlIC-ZCmz-k26IE7Z0gNdN',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    String? token,
    required Map<String, dynamic> dataFromUser,
  }) {
    dio!.options.headers = {
      'X-API-Uuid': '0678c71e-4096-464f-9b11-9ff147cd6282',
      'X-API-Key': '6cMSTnR6-eCBr-cTnA-yZS0-LljrbUaD1tmF',
      'X-API-Secret': 'SOx1G29U-Nem5-wlIC-ZCmz-k26IE7Z0gNdN',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return dio!.post(
      url,
      data: dataFromUser,
    );
  }

  static Future<Response> putData({
    required String url,
    String? token,
    required Map<String, dynamic> dataFromUser,
  }) {
    dio!.options.headers = {
      'X-API-Uuid': '0678c71e-4096-464f-9b11-9ff147cd6282',
      'X-API-Key': '6cMSTnR6-eCBr-cTnA-yZS0-LljrbUaD1tmF',
      'X-API-Secret': 'SOx1G29U-Nem5-wlIC-ZCmz-k26IE7Z0gNdN',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return dio!.post(
      url,
      data: dataFromUser,
    );
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) {
    dio!.options.headers = {
      'X-API-Uuid': '0678c71e-4096-464f-9b11-9ff147cd6282',
      'X-API-Key': '6cMSTnR6-eCBr-cTnA-yZS0-LljrbUaD1tmF',
      'X-API-Secret': 'SOx1G29U-Nem5-wlIC-ZCmz-k26IE7Z0gNdN',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return dio!.delete(url);
  }
}
