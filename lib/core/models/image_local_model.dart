import 'package:flutter/services.dart';
import 'package:travel_guide/core/constants/enums.dart';

class ImageLocalModel {
  final int id;
  final Uint8List? imagePath;
  AttachmentState attachmentState = AttachmentState.enqueue;
  String? upId;
  String? url;
  final String imageName;

  ImageLocalModel({
    required this.imageName,
    required this.id,
    required this.imagePath,
  });
}

class ImageModel {
  String? message;
  List<String>? data;

  ImageModel({this.message, this.data});

  ImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
