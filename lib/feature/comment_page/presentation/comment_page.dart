// import 'package:comment_tree/data/comment.dart';
// import 'package:comment_tree/widgets/comment_tree_widget.dart';
// import 'package:comment_tree/widgets/tree_theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:travel_guide/core/constants/styles.dart';
// import 'package:travel_guide/core/utils/themes.dart';
// import 'package:travel_guide/core/utils/utils.dart';
// import 'package:travel_guide/feature/comment_page/bloc/comment_cubit.dart';
// import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
// import 'package:travel_guide/injection.dart';
//
// class CommentPage extends StatefulWidget {
//   const CommentPage({
//     super.key,
//     required this.activityId,
//   });
//
//   final int activityId;
//
//   @override
//   State<CommentPage> createState() => _CommentPageState();
// }
//
// class _CommentPageState extends State<CommentPage> {
//   final FocusNode focusNode = FocusNode();
//   final TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     AppTheme theme = sl<ThemeCubit>().globalAppTheme;
//     return BlocProvider(
//       create: (context) =>
//           CommentCubit()..getCommentForCurrentPost(widget.activityId),
//       child: Builder(builder: (context) {
//         return Scaffold(
//           appBar: AppBar(
//             iconTheme: IconThemeData(color: theme.black),
//             elevation: 0,
//             title: Text("Comments"),
//           ),
//           body: BlocListener(
//             listener: (context, state) {
//               if (state is AddCommentError) {
//                 Utils.showCustomToast(state.error);
//               }
//             },
//             bloc: context.read<CommentCubit>(),
//             child: BlocBuilder(
//               buildWhen: (previous, current) {
//                 if (current is CompleteGetAllComment) return true;
//                 if (current is LoadingGetAllComment) return true;
//                 if (current is ErrorGetAllComment) return true;
//                 return false;
//               },
//               bloc: context.read<CommentCubit>(),
//               builder: (context, state) {
//                 if (state is LoadingGetAllComment) {
//                   return const CommentLoadingWidget();
//                 }
//                 return Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: context.read<CommentCubit>().commentList.isEmpty
//                           ? Center(
//                               child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "no comment to show",
//                                   style: StylesText.defaultTextStyle,
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     context
//                                         .read<CommentCubit>()
//                                         .getCommentForCurrentPost(
//                                             widget.activityId);
//                                   },
//                                   child: Text(
//                                     "try again",
//                                     style: StylesText.defaultTextStyle
//                                         .copyWith(color: theme.mainAppColor),
//                                   ),
//                                 )
//                               ],
//                             ))
//                           : ListView.builder(
//                               padding: EdgeInsets.zero,
//                               itemBuilder: (context, index) {
//                                 if (index ==
//                                     context
//                                         .read<CommentCubit>()
//                                         .commentList
//                                         .length) {
//                                   return GettingNewCommentTheWholeWidget(
//                                     theme: theme,
//                                     adsId: widget.adsId,
//                                   );
//                                 }
//                                 return CommentItemBuilder(
//                                   commentModel: context
//                                       .read<CommentCubit>()
//                                       .commentList[index],
//                                 );
//                               },
//                               itemCount: context
//                                       .read<CommentCubit>()
//                                       .commentList
//                                       .length +
//                                   1,
//                             ),
//                     ),
//                     ChatUITextField(
//                       focusNode: focusNode,
//                       textEditingController: controller,
//                       onSend: (commentText) {
//                         context.read<CommentCubit>().addComment(
//                               AddCommentParamsModel(
//                                   adsId: widget.adsId, comment: commentText),
//                             );
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class CommentItemBuilder extends StatelessWidget {
//   const CommentItemBuilder({
//     Key? key,
//     required this.commentModel,
//   }) : super(key: key);
//   final CommentModel commentModel;
//   @override
//   Widget build(BuildContext context) {
//     AppTheme theme = sl<ThemeCubit>().globalAppTheme;
//     Comment comment = Comment(
//       avatar: commentModel.user?.image,
//       userName: commentModel.user?.name,
//       content: commentModel.comment ?? "",
//     );
//     return Container(
//       margin: const EdgeInsets.all(10),
//       child: CommentTreeWidget<Comment, Comment>(
//         comment,
//         const [],
//         treeThemeData:
//             const TreeThemeData(lineColor: Colors.transparent, lineWidth: 3),
//         avatarRoot: (context, data) => PreferredSize(
//           preferredSize: const Size.fromRadius(18),
//           child: E3lanatyUserAvatar(
//               width: 10.w,
//               imageUrl: commentModel.user?.image?.split("/").last ?? ""),
//         ),
//         contentRoot: (context, data) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                 decoration: BoxDecoration(
//                     color: theme.reserveDarkScaffold,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       commentModel.user?.id == AppSettings().identity?.serverId
//                           ? AppLocalizations.of(context)?.translate('you') ?? ""
//                           : data.userName ?? "",
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             fontWeight: FontWeight.w600,
//                             color: theme.greyWeak,
//                           ),
//                     ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     Text(
//                       data.content ?? "",
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             fontWeight: FontWeight.w300,
//                             color: theme.white,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
