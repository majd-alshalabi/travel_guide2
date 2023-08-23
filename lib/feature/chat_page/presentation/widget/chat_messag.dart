import 'dart:io';

class ChatMessage {
  final bool isTextMessage;
  final bool iSend;
  final String message;
  final String date;
  final File? image;

  ChatMessage({
    required this.isTextMessage,
    required this.iSend,
    required this.message,
    required this.date,
    this.image,
  });
}