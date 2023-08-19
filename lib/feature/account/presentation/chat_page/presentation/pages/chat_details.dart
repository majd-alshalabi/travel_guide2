import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/account/presentation/chat_page/presentation/widget/chat_messag.dart';
import 'package:travel_guide/feature/account/presentation/chat_page/presentation/widget/image_message_widget.dart';
import 'package:travel_guide/feature/account/presentation/chat_page/presentation/widget/text_message.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key, required this.senderName});

  final String senderName;

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final TextEditingController _textEditingController = TextEditingController();
  late ValueNotifier<List<ChatMessage>> _messagesNotifier;
  bool _isTextEmpty = true; // Track if the text field is empty or not

  File? _image;

  @override
  void initState() {
    super.initState();
    _messagesNotifier = ValueNotifier<List<ChatMessage>>([]);
  }

  @override
  void dispose() {
    _messagesNotifier.dispose();
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      _sendImageMessage(_image!);
      _image = null;
    }
  }

  void _sendMessage() {
    final text = _textEditingController.text;
    if (_image != null || text.trim().isNotEmpty) {
      if (_image != null) {
        _sendImageMessage(_image!);
        _image = null;
      } else {
        _sendTextMessage(text);
      }
      _textEditingController.clear();
      setState(() {
        _isTextEmpty = true;
      });
    }
  }

  void _sendTextMessage(String text) {
    if (text.trim().isNotEmpty) {
      final newMessage = ChatMessage(
        isTextMessage: true,
        iSend: true,
        message: text,
        date: "10/7",
      );
      _messagesNotifier.value = [..._messagesNotifier.value, newMessage];
      _textEditingController.clear();
    }
  }

  void _sendImageMessage(File image) {
    final newMessage = ChatMessage(
      isTextMessage: false,
      iSend: false,
      message: '',
      date: "10/7",
      image: image,
    );
    _messagesNotifier.value = [..._messagesNotifier.value, newMessage];
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Scaffold(
      appBar: CustomAppBar(title: "Sadasdasdas"),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: _messagesNotifier,
              builder: (context, messages, _) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    if (message.isTextMessage) {
                      return TextMessageWidget(
                        iSend: message.iSend,
                        message: message.message,
                        date: message.date,
                        image: '',
                      );
                    } else if (message.image != null) {
                      return ImageMessageWidget(
                        iSend: message.iSend,
                        message: message.message,
                        date: message.date,
                        image: message.image!,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: theme.greyWeak,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      height: 56,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (event) {
                          if (event.runtimeType == RawKeyDownEvent &&
                              event.logicalKey == LogicalKeyboardKey.enter) {
                            _sendMessage();
                          }
                        },
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          controller: _textEditingController,
                          onChanged: (text) {
                            setState(() {
                              _isTextEmpty = text.trim().isEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: theme.white,
                            ),
                            border: InputBorder.none,
                            suffixIcon: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: _getImageFromGallery,
                              child: Icon(Icons.image_search_sharp),
                            ),
                          ),
                          onFieldSubmitted: (text) {
                            _sendMessage();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 20, top: 10),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.greyWeak,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: Icon(
                        Icons.send,
                        color: theme.darkThemeForScafold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
