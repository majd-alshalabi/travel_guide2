part of 'upload_image_cubit.dart';

@immutable
abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageLoaded extends UploadImageState {}

class UploadImageError extends UploadImageState {}

class UploadImageUpdateAttachmentStateLoading extends UploadImageState {}

class UploadImageUpdateAttachmentStateLoaded extends UploadImageState {
  final AttachmentState attachmentState;
  final String upId;

  UploadImageUpdateAttachmentStateLoaded({
    required this.attachmentState,
    required this.upId,
  });
}

class UploadImageUpdateProgressLoading extends UploadImageState {}

class UploadImageUpdateProgressLoaded extends UploadImageState {
  final double progress;
  final String upId;

  UploadImageUpdateProgressLoaded({
    required this.progress,
    required this.upId,
  });
}

class UploadImageUpdateImageUpIdLoading extends UploadImageState {}

class UploadImageUpdateImageUpIdLoaded extends UploadImageState {
  final int id;
  final String upId;

  UploadImageUpdateImageUpIdLoaded({
    required this.id,
    required this.upId,
  });
}
