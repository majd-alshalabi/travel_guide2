import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/chat_page/presentation/pages/screens/chat_details.dart';
import 'package:travel_guide/feature/chat_page/presentation/services/chat_service/guide_chats_service.dart';
import 'package:travel_guide/feature/comment_page/presentation/widget/comments_widgets.dart';
import 'package:travel_guide/feature/guides/presentation/cubits/guides_cubit/guides_cubit.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class ChatPageForGuide extends StatefulWidget {
  const ChatPageForGuide({Key? key}) : super(key: key);

  @override
  State<ChatPageForGuide> createState() => _ChatPageForGuideState();
}

class _ChatPageForGuideState extends State<ChatPageForGuide> {
  GuideChatService chatService = GuideChatService();

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => GuidesCubit(guide: chatService),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: theme.darkThemeForScafold,
            appBar: CustomAppBar(title: "chats"),
            body: BlocBuilder<GuidesCubit, GuidesState>(
              buildWhen: (previous, current) {
                if (current is GetChatListFromFirebaseLoaded) return true;
                return false;
              },
              builder: (context, state) {
                if (context.read<GuidesCubit>().chats.isEmpty) {
                  return Center(
                    child: Text(
                      "there is not chats currently",
                      style: StylesText.newDefaultTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) => UserItemForChat(
                    user: context.read<GuidesCubit>().user.length > index
                        ? context.read<GuidesCubit>().user[index]
                        : UserModel(
                            id: context.read<GuidesCubit>().chats[index],
                          ),
                  ),
                  itemCount: context.read<GuidesCubit>().chats.length,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class UserItemForChat extends StatelessWidget {
  const UserItemForChat({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return BlocBuilder<GuidesCubit, GuidesState>(
      buildWhen: (previous, current) {
        if (current is GetChatListLoaded) {
          int index = context
              .read<GuidesCubit>()
              .user
              .indexWhere((element) => element.id == user.id);
          if (index != -1) {
            user.image = context.read<GuidesCubit>().user[index].image;
            user.name = context.read<GuidesCubit>().user[index].name;
            return true;
          }
        } else if (current is GetChatListError) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  guide: AdminModel(
                    type: UserType.user,
                    name: user.name,
                    image: user.image,
                    id: user.id,
                  ),
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            decoration: BoxDecoration(
              color: theme.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TravelGuideUserAvatar(
                  width: 13.w,
                  imageUrl: user.image ?? "",
                ),
                SizedBox(
                  width: 3.w,
                ),
                if (user.name != null)
                  Text(
                    user.name ?? "",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: Colors.black),
                  )
                else
                  UserLoadingWidget(),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: theme.reserveDarkScaffold,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
