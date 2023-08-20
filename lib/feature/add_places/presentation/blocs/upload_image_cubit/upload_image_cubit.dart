import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/core/models/image_local_model.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/services/network/network_service.dart';
import 'package:travel_guide/core/upload_images_services/upload_attachment_service.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  final BackgroundUploader uploader = BackgroundUploader();
  final String type;
  UploadImageCubit(this.type) : super(UploadImageInitial()) {
    uploader.updateNotificationPage.stream.listen((event) {
      if (event.attachmentState == AttachmentState.enqueue) {
        updateProgress(progress: event.progress ?? 0, upId: event.taskId);
      } else {
        updateAttachmentState(
          upId: event.taskId,
          attachmentState: event.attachmentState,
          url: event.attachmentUrl,
        );
      }
    });
  }
  List<ImageLocalModel> attachments = [];
  int currentId = 1;
  void addImage() async {
    emit(UploadImageLoading());
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final model = ImageLocalModel(
        imageName: file.name,
        imagePath: await file.readAsBytes(),
        id: currentId++,
      );

      attachments.add(model);

      emit(UploadImageLoaded());
      final headers = await NetworkServices.initTokenAndHeaders();
      uploader
          .enqueueFile(
            type: type,
            fileName: model.imageName,
            filePath: model.imagePath!,
            headers: headers,
            url:
                "${NetworkConfigurations.BaseUrl}${NetworkConfigurations.kUploadImage}",
          )
          .then(
            (value) => updateAttachmentUpId(id: model.id, upId: value),
          );
    } else {
      emit(UploadImageError());
    }
  }

  void updateAttachmentState({
    required AttachmentState attachmentState,
    required String upId,
    String? url,
  }) {
    emit(UploadImageUpdateAttachmentStateLoading());
    int index = attachments.indexWhere((element) => element.upId == upId);
    if (index != -1) {
      attachments[index].attachmentState = attachmentState;
      if (url != null) {
        attachments[index].url = url;
      }
    }
    emit(
      UploadImageUpdateAttachmentStateLoaded(
          upId: upId, attachmentState: attachmentState),
    );
  }

  void initState(List<ImageModel> images) {
    attachments.addAll(
      images.map((e) {
        final model =
            ImageLocalModel(id: currentId++, imagePath: null, imageName: "");
        model.attachmentState = AttachmentState.completed;
        model.url = e.data?.first ?? "";
        return model;
      }),
    );
  }

  void updateProgress({
    required String upId,
    required double progress,
  }) {
    emit(UploadImageUpdateProgressLoading());
    emit(UploadImageUpdateProgressLoaded(progress: progress, upId: upId));
  }

  void updateAttachmentUpId({
    required String upId,
    required int id,
  }) {
    emit(UploadImageUpdateImageUpIdLoading());
    int index = attachments.indexWhere((element) => element.id == id);
    if (index != -1) {
      attachments[index].upId = upId;
    }
    emit(UploadImageUpdateImageUpIdLoaded(id: id, upId: upId));
  }

  void cancelUploading(int id) {
    emit(UploadImageUpdateAttachmentStateLoading());
    int index = attachments.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      attachments[index].attachmentState = AttachmentState.failed;
      emit(
        UploadImageUpdateAttachmentStateLoaded(
          upId: attachments[index].upId ?? "",
          attachmentState: AttachmentState.failed,
        ),
      );
      uploader.cancelTask(attachments[index].upId ?? "");
    }
  }

  void retry(int id) async {
    emit(UploadImageUpdateAttachmentStateLoading());
    int index = attachments.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      attachments[index].attachmentState = AttachmentState.enqueue;
      emit(
        UploadImageUpdateAttachmentStateLoaded(
          upId: attachments[index].upId ?? "",
          attachmentState: AttachmentState.enqueue,
        ),
      );
      final headers = await NetworkServices.initTokenAndHeaders();
      uploader
          .enqueueFile(
            type: type,
            fileName: attachments[index].imageName,
            filePath: attachments[index].imagePath!,
            headers: headers,
            url:
                "${NetworkConfigurations.BaseUrl}${NetworkConfigurations.kUploadImage}",
          )
          .then(
            (value) =>
                updateAttachmentUpId(id: attachments[index].id, upId: value),
          );
    }
  }

  void removeAttachment(int id) {
    emit(UploadImageLoading());
    int index = attachments.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      if (attachments[index].attachmentState == AttachmentState.enqueue) {
        uploader.cancelTask(attachments[index].upId ?? "");
      }
      attachments.removeAt(index);
      emit(UploadImageLoaded());
    }
  }

  void clearList() {
    emit(UploadImageLoading());
    attachments.clear();
    emit(UploadImageLoaded());
  }
}
