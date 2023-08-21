import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/comment_page/bloc/comment_cubit.dart';
import 'package:travel_guide/feature/comment_page/presentation/widget/comments_widgets.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    super.key,
    required this.activityId,
  });

  final int activityId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) =>
          CommentCubit()..getCommentForCurrentPost(widget.activityId),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: theme.white),
            elevation: 0,
            title: Text("reviews"),
          ),
          body: BlocListener(
            listener: (context, state) {
              if (state is AddCommentError) {
                Utils.showCustomToast(state.error);
              }
            },
            bloc: context.read<CommentCubit>(),
            child: BlocBuilder(
              buildWhen: (previous, current) {
                if (current is CompleteGetAllComment) return true;
                if (current is LoadingGetAllComment) return true;
                if (current is ErrorGetAllComment) return true;
                return false;
              },
              bloc: context.read<CommentCubit>(),
              builder: (context, state) {
                if (state is LoadingGetAllComment) {
                  return CommentLoadingWidget();
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: context.read<CommentCubit>().commentList.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "no comment to show",
                                  style: StylesText.newDefaultTextStyle
                                      .copyWith(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<CommentCubit>()
                                        .getCommentForCurrentPost(
                                            widget.activityId);
                                  },
                                  child: Text(
                                    "try again",
                                    style: StylesText.defaultTextStyle
                                        .copyWith(color: theme.mainAppColor),
                                  ),
                                )
                              ],
                            ))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return CommentItemBuilder(
                                  commentModel: context
                                      .read<CommentCubit>()
                                      .commentList[index],
                                );
                              },
                              itemCount: context
                                  .read<CommentCubit>()
                                  .commentList
                                  .length,
                            ),
                    ),
                    ChatUITextField(
                      focusNode: focusNode,
                      textEditingController: controller,
                      onSend: (commentText) {
                        context.read<CommentCubit>().addComment(
                              AddCommentParamsModel(
                                activityId: widget.activityId,
                                message: commentText,
                              ),
                            );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class CommentItemBuilder extends StatelessWidget {
  const CommentItemBuilder({
    Key? key,
    required this.commentModel,
  }) : super(key: key);
  final CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    Comment comment = Comment(
      avatar: commentModel.user?.image,
      userName: commentModel.user?.name,
      content: commentModel.message ?? "",
    );
    return Container(
      margin: const EdgeInsets.all(10),
      child: CommentTreeWidget<Comment, Comment>(
        comment,
        const [],
        treeThemeData:
            const TreeThemeData(lineColor: Colors.transparent, lineWidth: 3),
        avatarRoot: (context, data) => PreferredSize(
          preferredSize: const Size.fromRadius(18),
          child: TravelGuideUserAvatar(
              width: 10.w,
              imageUrl: commentModel.user?.image?.split("/").last ?? ""),
        ),
        contentRoot: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: theme.reserveDarkScaffold,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.userName ?? "",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.greyWeak,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.content ?? "",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: theme.white,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChatUITextField extends StatefulWidget {
  const ChatUITextField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.onSend,
  }) : super(key: key);

  /// Provides focusNode for focusing text field.
  final FocusNode focusNode;

  /// Provides functions which handles text field.
  final TextEditingController textEditingController;

  final Function(String) onSend;

  @override
  State<ChatUITextField> createState() => _ChatUITextFieldState();
}

class _ChatUITextFieldState extends State<ChatUITextField> {
  final ValueNotifier<String> _inputText = ValueNotifier('');

  OutlineInputBorder get _outLineBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      );
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    if (AppSettings().identity == null) {
      return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.greyWeak,
        ),
        child: Text(
          "Log in to interact",
          style: StylesText.newDefaultTextStyle.copyWith(color: theme.black),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.greyWeak,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.darkThemeForScafold,
                fontSize: 14,
              ),
              textCapitalization: TextCapitalization.sentences,
              cursorColor: theme.darkThemeForScafold,
              onChanged: (value) {
                _inputText.value = value;
              },
              decoration: InputDecoration(
                hintText: "enter comment",
                fillColor: Colors.transparent,
                filled: true,
                hintStyle: StylesText.newDefaultTextStyle.copyWith(
                  color: theme.darkThemeForScafold,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                border: _outLineBorder,
                focusedBorder: _outLineBorder,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<String>(
              valueListenable: _inputText,
              builder: (_, inputTextValue, child) {
                if (inputTextValue.isEmpty) return const Offstage();

                return IconButton(
                  color: theme.darkThemeForScafold,
                  onPressed: () {
                    widget.onSend.call(widget.textEditingController.text);
                    _inputText.value = '';
                    widget.textEditingController.clear();
                    widget.focusNode.unfocus();
                  },
                  icon: const FaIcon(FontAwesomeIcons.circleArrowRight),
                );
              }),
        ],
      ),
    );
  }
}
