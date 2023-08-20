import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/enums.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/models/image_local_model.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/feature/add_places/presentation/blocs/upload_image_cubit/upload_image_cubit.dart';

class CreateActivityAttachmentSection extends StatelessWidget {
  const CreateActivityAttachmentSection({
    Key? key,
    required this.smallSize,
  }) : super(key: key);
  final bool smallSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            FocusScope.of(context).unfocus();
            context.read<UploadImageCubit>().addImage();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Corners.sm),
              border: Border.all(color: Colors.black38),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: const FaIcon(FontAwesomeIcons.pinterest),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1.w),
                  child: Text(
                    "Upload Image",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        ActivityScreenImageSection(smallSize: smallSize),
      ],
    );
  }
}

class ActivityScreenImageSection extends StatelessWidget {
  final bool smallSize;
  const ActivityScreenImageSection({
    Key? key,
    required this.smallSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<UploadImageCubit>(),
      buildWhen: (previous, current) {
        if (current is UploadImageLoaded) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (context.read<UploadImageCubit>().attachments.isNotEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: CarouselSlider(
              options: CarouselOptions(
                padEnds: false,
                height: 40.w,
                viewportFraction: 0.3,
                initialPage: 1,
                reverse: false,
                enableInfiniteScroll: false,
                animateToClosest: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.linear,
                scrollDirection: Axis.horizontal,
                disableCenter: true,
              ),
              items: context
                  .read<UploadImageCubit>()
                  .attachments
                  .map((attachment) {
                return BlocBuilder(
                  bloc: context.read<UploadImageCubit>(),
                  buildWhen: (previous, current) {
                    if (current is UploadImageUpdateAttachmentStateLoaded) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return ActivityImageContainer(
                      smallSize: smallSize,
                      imageModel: attachment,
                    );
                  },
                );
              }).toList(),
            ),
          );
        }
        return const Offstage();
      },
    );
  }
}

class ActivityImageContainer extends StatelessWidget {
  final ImageLocalModel imageModel;
  final bool smallSize;
  const ActivityImageContainer(
      {super.key, required this.imageModel, required this.smallSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: smallSize ? 15.w : 25.w,
              width: smallSize ? 15.w : 25.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Corners.s10),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Corners.s10),
                child: imageModel.imagePath != null
                    ? Image.memory(
                        imageModel.imagePath!,
                        errorBuilder: (ctx, _, __) {
                          return const BlurHash(hash: "000000");
                        },
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            "${NetworkConfigurations.BaseUrl}${imageModel.url}",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          if (imageModel.attachmentState == AttachmentState.enqueue) ...[
            BlocBuilder(
                bloc: context.read<UploadImageCubit>(),
                buildWhen: (previous, current) {
                  if (current is UploadImageUpdateProgressLoaded &&
                      current.upId == imageModel.upId) {
                    return true;
                  }
                  return false;
                },
                builder: (context, current) {
                  if (current is UploadImageUpdateProgressLoaded &&
                      current.upId == imageModel.upId) {
                    return LoadingWidget(
                      value: current.progress,
                      onTap: () {
                        context
                            .read<UploadImageCubit>()
                            .cancelUploading(imageModel.id);
                      },
                    );
                  }
                  return LoadingWidget(
                    onTap: () {
                      context
                          .read<UploadImageCubit>()
                          .cancelUploading(imageModel.id);
                    },
                  );
                })
          ] else if (imageModel.attachmentState == AttachmentState.failed) ...[
            RetryWidget(
              onTap: () {
                context.read<UploadImageCubit>().retry(imageModel.id);
              },
            )
          ],
          RemoveWidget(
            onTap: () {
              context.read<UploadImageCubit>().removeAttachment(imageModel.id);
            },
          ),
        ],
      ),
    );
  }
}

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 2,
      right: 2,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: InkWell(
          onTap: () {
            onTap.call();
          },
          child: const Icon(
            Icons.settings_backup_restore,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.value,
    required this.onTap,
  }) : super(key: key);
  final double? value;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 2,
      right: 2,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              color: Colors.blue,
              value: value,
              strokeWidth: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                highlightElevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                onPressed: () {
                  onTap.call();
                },
                child: const Center(
                    child: Icon(
                  Icons.clear,
                  color: Colors.white,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RemoveWidget extends StatelessWidget {
  const RemoveWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2,
      left: 2,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: InkWell(
          onTap: () {
            onTap.call();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
