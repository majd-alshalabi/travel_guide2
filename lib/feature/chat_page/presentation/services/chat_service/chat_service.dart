import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

class ChatService {
  final DatabaseReference messagesRef =
      FirebaseDatabase.instance.ref('messages');

  StreamSubscription? streamSubscription;
  final AdminModel user;
  StreamController<ChatEvent> chatStream =
      StreamController<ChatEvent>.broadcast();
  ChatService(this.user) {
    streamSubscription = messagesRef.onChildAdded.listen((event) {
      final FirebaseMessageModel model = FirebaseMessageModel.fromJson(
        jsonDecode(jsonEncode(event.snapshot.value)),
      );

      final String myId = Utils.getIdForChat(
          AppSettings().identity?.serverId ?? -1,
          AppSettings().identity?.guide ?? UserType.user);
      final String receiverId =
          Utils.getIdForChat(user.id ?? -1, user.type ?? UserType.user);
      if ((model.senderId == myId && model.receiverId == receiverId) ||
          (model.senderId == receiverId && model.receiverId == myId)) {
        chatStream.add(AddNewMessageFromStreamEvent(model));
      }
    });
  }
  void saveMessage(FirebaseMessageModel message) {
    messagesRef.push().set(message.toJson());
  }
}

class FirebaseMessageModel {
  String? senderId;
  String? receiverId;
  String? message;
  int? type;
  String? link;
  String? id;
  int? created_at;

  FirebaseMessageModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.type,
    this.link,
    this.created_at,
    this.id,
  });

  FirebaseMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    type = json['type'];
    link = json['link'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['id'] = this.id;
    data['message'] = this.message;
    data['type'] = this.type;
    data['created_at'] = this.created_at;
    data['link'] = this.link;
    return data;
  }
}

abstract class ChatEvent {}

class AddNewMessageFromStreamEvent extends ChatEvent {
  final FirebaseMessageModel message;

  AddNewMessageFromStreamEvent(this.message);
}
