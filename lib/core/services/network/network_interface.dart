import 'package:dio/dio.dart';

class RemoteDataBundle {
  final String networkPath;
  Map<String, dynamic> body;
  Map<String, dynamic> urlParams;
  final FormData? data;

  RemoteDataBundle({
    this.data,
    required this.body,
    required this.networkPath,
    required this.urlParams,
  });
}

abstract class IRemoteDataSource {
  Future<dynamic> get(RemoteDataBundle remoteBundle);
  Future<dynamic> post(RemoteDataBundle remoteBundle);
  Future<dynamic> postFormData(RemoteDataBundle remoteBundle);
}
