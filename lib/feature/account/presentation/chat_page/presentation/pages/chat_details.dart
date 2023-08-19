import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.guide});

  final GuideModel guide;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  late types.User _user;

  @override
  void initState() {
    super.initState();
    _user = types.User(
      id: widget.guide.id.toString() + "guide",
      firstName: widget.guide.name ?? "",
      imageUrl: NetworkConfigurations.BaseUrl + (widget.guide.image ?? ""),
    );
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: (context, p1) {},
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: DefaultChatTheme(
            inputTextStyle: StylesText.newDefaultTextStyle,
            dateDividerTextStyle:
                StylesText.newDefaultTextStyle.copyWith(color: Colors.black),
            receivedMessageBodyBoldTextStyle: StylesText.newDefaultTextStyle,
            sentMessageBodyTextStyle: StylesText.newDefaultTextStyle,
            messageInsetsHorizontal: 15,
            messageInsetsVertical: 15,
          ),
        ),
      );
}
