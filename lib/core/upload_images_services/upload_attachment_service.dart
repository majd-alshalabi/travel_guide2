import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:uuid/uuid.dart';

class BackgroundUploader {
  Map<String, CancelToken> cancelMap = {};
  final Dio dio = Dio();
  final StreamController<UploadImagesState> updateNotificationPage =
      StreamController<UploadImagesState>.broadcast();

  Future<String> enqueueFile({
    required String fileName,
    required Uint8List filePath,
    required Map<String, String> headers,
    required String url,
    required String type,
  }) async {
    final String taskId = const Uuid().v4();
    final CancelToken cancelToken = CancelToken();
    cancelMap[taskId] = cancelToken;
    FormData body = FormData();
    final MultipartFile file =
        MultipartFile.fromBytes(filePath, filename: fileName);
    MapEntry<String, MultipartFile> imageEntry = MapEntry("images[0]", file);
    body.files.add(imageEntry);
    body.fields.add(MapEntry("type", type));
    dio.post(
      url,
      data: body,
      options: Options(headers: headers, responseType: ResponseType.json),
      onSendProgress: (count, total) {
        updateNotificationPage.add(
          UploadImagesState(
            taskId: taskId,
            attachmentState: AttachmentState.enqueue,
            progress: count / total,
          ),
        );
      },
      cancelToken: cancelToken,
    ).then((value) {
      print(value);
      print("adsgadsga");
      _returnResponse(value, taskId);
    });
    return taskId;
  }

  _returnResponse(Response response, String taskId) async {
    print(response.data);
    print("Adsgadsgdsa");
    print(response);
    try {
      switch (response.statusCode) {
        case 200:
        case 201:
          updateNotificationPage.add(
            UploadImagesState(
              attachmentState: AttachmentState.completed,
              taskId: taskId,
              attachmentUrl: response.data['data'][0],
            ),
          );
        default:
          updateNotificationPage.add(
            UploadImagesState(
              attachmentState: AttachmentState.failed,
              taskId: taskId,
            ),
          );
      }
    } catch (e) {
      updateNotificationPage.add(
        UploadImagesState(
          attachmentState: AttachmentState.failed,
          taskId: taskId,
        ),
      );
    }
    cancelMap.removeWhere((key, value) => key == taskId);
  }

  void cancelTask(String taskId) {
    if (cancelMap.containsKey(taskId)) {
      CancelToken? cancelToken = cancelMap[taskId];
      cancelToken?.cancel();
      cancelMap.removeWhere((key, value) => key == taskId);
      updateNotificationPage.add(
        UploadImagesState(
            attachmentState: AttachmentState.failed, taskId: taskId),
      );
    }
  }

  void cancelAllTask() {
    cancelMap.forEach((key, value) {
      value.cancel();
      updateNotificationPage.add(
        UploadImagesState(attachmentState: AttachmentState.failed, taskId: key),
      );
    });
    cancelMap.clear();
  }
}

class UploadImagesState {
  final AttachmentState attachmentState;
  final String taskId;
  final double? progress;
  final String? attachmentUrl;

  UploadImagesState({
    this.attachmentUrl,
    required this.attachmentState,
    required this.taskId,
    this.progress,
  });
}
