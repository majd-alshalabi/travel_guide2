import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/services/network/network_interface.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/account/domain/use_cases/delete_my_identity_use_case.dart';
import 'package:travel_guide/feature/account/domain/use_cases/get_my_identity_use_case.dart';
import 'package:travel_guide/feature/account/presentation/login_page/presentation/login_page.dart';

class NetworkServices implements IRemoteDataSource {
  static Map<String, String> headers =
      Map<String, String>.from(NetworkConfigurations.BaseHeaders);

  static Future<Map<String, String>> initTokenAndHeaders() async {
    headers.clear();

    /// get token
    final res = await GetMyIdentityUseCase().call(NoParams());
    res.fold(
      (l) => null,
      (r) => headers.addAll({"Authorization": "Bearer ${r?.token}"}),
    );
    headers.addAll({"accept": "application/json"});
    return headers;
  }

  _returnResponse(Response response) async {
    var responseJson = json.decode(response.data);
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 401:
        if (AppSettings().navigatorKey.currentContext != null) {
          Utils.showCustomToast("please re login");
          await DeleteMyIdentityUseCase().call(NoParams());
          AppSettings().identity = null;
          Navigator.pushAndRemoveUntil(
            AppSettings().navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false,
          );
        }
        throw Exception("error");
      default:
        throw Exception("error");
    }
  }

  @override
  Future get(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();
      headers.addAll({"Content-Type": "application/json"});
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );
      Dio dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
      String addedValue = '';
      if (remoteBundle.networkPath != NetworkConfigurations.kRegister &&
          remoteBundle.networkPath != NetworkConfigurations.kLogin) {
        addedValue = (AppSettings().identity?.guide == UserType.guide
            ? "for_guide/"
            : "");
      }
      final Response response = await Dio().get(
        NetworkConfigurations.BaseUrl + addedValue + remoteBundle.networkPath,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
        data: remoteBundle.body,
        queryParameters: remoteBundle.urlParams,
      );
      print("result :");
      print(response.data);
      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      return _returnResponse(e.response!);
    }
  }

  @override
  Future getWither(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();
      headers.addAll({"Content-Type": "application/json"});
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );
      Dio dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
      final Response response = await Dio().get(
        "https://api.openweathermap.org/data/2.5/" + remoteBundle.networkPath,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
        data: remoteBundle.body,
        queryParameters: remoteBundle.urlParams,
      );
      print("result :");
      print(response.data);
      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      return _returnResponse(e.response!);
    }
  }

  @override
  Future post(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();
      headers.addAll({"Content-Type": "application/json"});
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );
      Dio dio = Dio(options);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
      String addedValue = '';
      if (remoteBundle.networkPath != NetworkConfigurations.kRegister &&
          remoteBundle.networkPath != NetworkConfigurations.kLogin) {
        addedValue = (AppSettings().identity?.guide == UserType.guide
            ? "for_guide/"
            : "");
      }
      final response = await dio.post(
        NetworkConfigurations.BaseUrl + addedValue + remoteBundle.networkPath,
        data: remoteBundle.body,
        queryParameters: remoteBundle.urlParams,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
      );
      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      return _returnResponse(e.response!);
    }
  }

  @override
  Future postFormData(RemoteDataBundle remoteBundle) async {
    try {
      await initTokenAndHeaders();

      headers.addAll({"Content-Type": "multipart/form-data"});
      var dio = Dio();
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      String addedValue = '';

      if (remoteBundle.networkPath != NetworkConfigurations.kRegister &&
          remoteBundle.networkPath != NetworkConfigurations.kLogin) {
        addedValue = (AppSettings().identity?.guide == UserType.guide
            ? "for_guide/"
            : "");
      }
      final response = await dio.post(
        NetworkConfigurations.BaseUrl + addedValue + remoteBundle.networkPath,
        data: remoteBundle.data,
        options: Options(headers: headers, responseType: ResponseType.plain),
      );
      headers.addAll({"Content-Type": "application/json"});

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response == null) throw Exception("no internet connection");
      _returnResponse(e.response!);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}
