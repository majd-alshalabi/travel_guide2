import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/chat_page/presentation/cubits/chat_main_cubit/chat_main_bloc.dart';
import 'package:travel_guide/feature/chat_page/presentation/services/chat_service/chat_service.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.guide});

  final AdminModel guide;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late types.User _user;

  @override
  void initState() {
    super.initState();
    _user = types.User(
      id: Utils.getIdForChat(
        AppSettings().identity?.serverId ?? -1,
        AppSettings().identity?.guide ?? UserType.user,
      ),
      firstName: AppSettings().identity?.name ?? "",
      imageUrl: NetworkConfigurations.BaseUrl +
          (AppSettings().identity?.imageUrl ?? ""),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    service.saveMessage(
      FirebaseMessageModel(
        message: textMessage.text,
        id: textMessage.id,
        receiverId:
            widget.guide.id.toString() + (widget.guide.type?.name ?? ""),
        type: 1,
        senderId: (AppSettings().identity?.serverId.toString() ?? "") +
            (AppSettings().identity?.guide.toString() ?? ""),
        created_at: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  late ChatService service = ChatService(widget.guide);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatMainBloc(service, widget.guide),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1d1c21),
            title: Row(
              children: [
                TravelGuideUserAvatar(
                  imageUrl: widget.guide.image ?? "",
                  width: 5.h,
                ),
                SizedBox(width: 8),
                Text(
                  widget.guide.name ?? "",
                  style: StylesText.newDefaultTextStyle,
                ),
              ],
            ),
          ),
          body: BlocBuilder<ChatMainBloc, ChatMainState>(
            buildWhen: (previous, current) {
              if (current is NewMessageAddStateLoaded) return true;
              return false;
            },
            builder: (context, state) {
              return Chat(
                messages: context.read<ChatMainBloc>().uiList,
                onMessageTap: (context, p1) {},
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                avatarBuilder: (userId) {
                  return TravelGuideUserAvatar(
                    imageUrl: widget.guide.image ?? "",
                    width: 8.w,
                  );
                },
                user: _user,
                theme: DarkChatTheme(
                  emptyChatPlaceholderTextStyle: StylesText.newDefaultTextStyle
                      .copyWith(color: Colors.white),
                  inputTextStyle: StylesText.newDefaultTextStyle,
                  dateDividerTextStyle: StylesText.newDefaultTextStyle
                      .copyWith(color: Colors.white),
                  receivedMessageBodyBoldTextStyle:
                      StylesText.newDefaultTextStyle,
                  sentMessageBodyTextStyle: StylesText.newDefaultTextStyle,
                  messageInsetsHorizontal: 15,
                  messageInsetsVertical: 15,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
