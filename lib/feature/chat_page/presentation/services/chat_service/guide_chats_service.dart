import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/core/utils/utils.dart';
import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';

class GuideChatService {
  final DatabaseReference messagesRef =
      FirebaseDatabase.instance.ref('messages');
  StreamSubscription? streamSubscription;
  StreamController<UpdateChatForGuide> chatStream =
      StreamController<UpdateChatForGuide>.broadcast();
  Set<String> chatList = {};
  GuideChatService() {
    initialStreams();
  }

  initialStreams() async {
    final String myId = Utils.getIdForChat(
        AppSettings().identity?.serverId ?? -1,
        AppSettings().identity?.guide ?? UserType.user);
    try {
      await messagesRef.once().then((DatabaseEvent value) {
        Map map = jsonDecode(jsonEncode(value.snapshot.value));
        map.forEach((key, values) {
          final FirebaseMessageModel model =
              FirebaseMessageModel.fromJson(values);
          if (!chatList.contains(model.senderId) &&
              model.senderId != myId &&
              model.receiverId == myId) {
            chatList.add(model.senderId ?? "");
          } else if (!chatList.contains(model.receiverId) &&
              model.receiverId != myId &&
              model.senderId == myId) {
            chatList.add(model.receiverId ?? "");
          }
        });
      });
    } catch (e) {}
    chatStream.add(UpdateChatsForGuide(chatList.toList()));
    streamSubscription = messagesRef.onChildAdded.listen((event) {
      final FirebaseMessageModel model = FirebaseMessageModel.fromJson(
        jsonDecode(jsonEncode(event.snapshot.value)),
      );
      if (!chatList.contains(model.senderId) &&
          model.senderId != myId &&
          model.receiverId == myId) {
        chatList.add(model.senderId ?? "");
        chatStream.add(UpdateChatsForGuide([model.senderId ?? ""]));
      } else if (!chatList.contains(model.receiverId) &&
          model.receiverId != myId &&
          model.senderId == myId) {
        chatList.add(model.receiverId ?? "");

        chatStream.add(UpdateChatsForGuide([model.receiverId ?? ""]));
      }
    });
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

abstract class UpdateChatForGuide {}

class UpdateChatsForGuide extends UpdateChatForGuide {
  final List<String> ids;

  UpdateChatsForGuide(this.ids);
}
