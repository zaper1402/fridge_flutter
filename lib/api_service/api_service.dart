
import 'package:dio/dio.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/app/globals.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get_storage/get_storage.dart';

class ApiBaseHelper {
  static String url = ApiEndPointUrls.apiBaseUrl;

  ApiBaseHelper({String? baseURL}) {
    if (baseURL != null) {
      url = baseURL;
    } else {
      url = ApiEndPointUrls.apiBaseUrl;
    }
  }

  BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 200000,
    receiveTimeout: 200000,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  Dio createDio() {
    Dio dio = Dio();
    var options = opts;
    String accessToken = GetStorage().read(SharedPreference.userAccessToken) ?? "";
    print("accessToken $accessToken");

    var headers = <String, dynamic>{};
    headers.addAll({
      "timezone-offset": (DateTime.now().toUtc().timeZoneOffset.inMilliseconds -
          DateTime.now().timeZoneOffset.inMilliseconds),
      "version": "1.0",
      "access-token": accessToken,
    });

    options.headers.addAll(headers);
    options.receiveDataWhenStatusError = true;
    options.responseType = ResponseType.json;
    options.contentType = Headers.jsonContentType;
    options.baseUrl = url;

    dio.options = options;

    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        logPrint: (object) {
          print("logPrint $object");
        }));

    return dio;
  }

  Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(onRequest: (options, handler) async {
          // Do something before request is sent
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        }, onResponse: (response, handler) {
          // Do something with response data

          return handler.next(response); // continue

          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        }, onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            return handler.resolve(await _retry(e.requestOptions));
          }

          // Do something with response error
          // logToConsole(
          //     'error data1-' + e.requestOptions.path, e.error.toString());
          return handler.next(e); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        }),
      );
  }

  static dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  Dio get baseAPI {
    return addInterceptors(createDio());
  }

  Future getHTTP(String url, {Map<String, dynamic>? queryParameters}) async {
    /*if (Globals.connectivityResult == null) {
      var connectivityResult = await Connectivity().checkConnectivity();
      Globals.setConnectivity(connectivityResult);
    }*/
    // var connectivityResult = await Connectivity().checkConnectivity();
    // Globals.setConnectivity(connectivityResult);
    // if (Globals.connectivityResult == ConnectivityResult.none) {
    //   return DioError(
    //       requestOptions: RequestOptions(path: ''),
    //       error:
    //           'Something went wrong. Please check your internet connection or try again later.');
    // }
    try {
      Response response =
          await baseAPI.get(url, queryParameters: queryParameters);
          print("getHttp ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Future.error('Woops Someting went worng');
        return response.data;
      }
    } on DioError catch (e) {
      return e;
    }
  }

  Future<Response> postHTTP(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    /*if (Globals.connectivityResult == null) {
      var connectivityResult = await Connectivity().checkConnectivity();
      Globals.setConnectivity(connectivityResult);
    }*/
    // var connectivityResult = await Connectivity().checkConnectivity();
    // Globals.setConnectivity(connectivityResult);

    // if (Globals.connectivityResult == ConnectivityResult.none) {
    //   /*return DioError(
    //       requestOptions: RequestOptions(path: ''),
    //       error:
    //           'Something went wrong. Please check your internet connection or try again later.');*/
    //   return Future.error(
    //       "Something went wrong. Please check your internet connection or try again later.");
    //   //Response(requestOptions: RequestOptions(path: ''),statusCode: 400);
    // }
    try {
      print("URL : $url $data");
      Response response =
          await baseAPI.post(url, data: data, queryParameters: queryParameters);
      print("Success ${response.statusCode} ${response.data}");
      return response;
    } on DioError catch (e) {
      print("Error : $e");
      return Future.error(
          e); //Response(requestOptions: e.requestOptions,statusCode: 400);
      // Handle error
    }
  }

  Future putHTTP(String url, dynamic data) async {
    // if (Globals.connectivityResult == null) {
    //   var connectivityResult = await Connectivity().checkConnectivity();
    //   Globals.setConnectivity(connectivityResult);
    // }
    // if (Globals.connectivityResult == ConnectivityResult.none) {
    //   return DioError(
    //       requestOptions: RequestOptions(path: ''),
    //       error:
    //           'Something went wrong. Please check your internet connection or try again later.');
    // }
    try {
      Response response = await baseAPI.put(url, data: data);
      if (response.statusCode == 200) {
        return response;
      } else {
        Future.error('Woops Someting went worng');
      }
    } on DioError catch (e) {
      // Handle error
      return e;
    }
  }

  Future downloadFile<T>(
    String url,
    Map<String, dynamic> data,
  ) async {
    // if (Globals.connectivityResult == null) {
    //   var connectivityResult = await Connectivity().checkConnectivity();
    //   Globals.setConnectivity(connectivityResult);
    // }
    // if (Globals.connectivityResult == ConnectivityResult.none) {
    //   return DioError(
    //       requestOptions: RequestOptions(path: ''),
    //       error:
    //           'Something went wrong. Please check your internet connection or try again later.');
    // }
    try {
      Response<T> response = await baseAPI.post<T>(url,
          data: data,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          ));
      if (response.statusCode == 200) {
        return response;
      } else {
        Future.error('Woops Someting went worng');
        return response;
      }
    } catch (err) {
      return err;
    }
  }

  Future deleteHTTP(String url) async {
    // if (Globals.connectivityResult == null) {
    //   var connectivityResult = await Connectivity().checkConnectivity();
    //   Globals.setConnectivity(connectivityResult);
    // }
    // if (Globals.connectivityResult == ConnectivityResult.none) {
    //   return DioError(
    //       requestOptions: RequestOptions(path: ''),
    //       error:
    //           'Something went wrong. Please check your internet connection or try again later.');
    // }
    try {
      Response response = await baseAPI.delete(url);
      if (response.statusCode == 200) {
        return response;
      } else {
        Future.error('Woops Someting went worng');
      }
    } on DioError catch (e) {
      // Handle error
      return e;
    }
  }

  Future postFormDataHttp({
    required String url,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await baseAPI.post(url,
          data: formData,
          queryParameters: queryParameters,
          onSendProgress: (a, b) {});
      print("response is >>> $response");
      return response;
    } on DioError catch (e) {
      // Handle error
      return e;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return baseAPI.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
