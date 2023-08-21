import 'package:travel_guide/feature/account/data/models/remote/login_model.dart';

class MyIdentity {
  int? id;
  String? phoneNumber;
  String? name;
  String? email;
  int? serverId;
  String? imageUrl;
  String? token;
  String? location;
  String? createdAt;
  int? notificationType;
  UserType? guide;

  MyIdentity({
    this.id,
    this.notificationType,
    this.serverId,
    this.phoneNumber,
    this.email,
    this.guide,
    this.name,
    this.imageUrl,
    this.token,
    this.location,
    this.createdAt,
  });

  MyIdentity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationType = json['notificationType'];
    phoneNumber = json['phoneNumber'];
    phoneNumber = json['serverId'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    token = json['token'];
    location = json['location'];
    createdAt = json['createdAt'];
    guide = UserType.formInt(json['guide']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['serverId'] = serverId;
    data['email'] = email;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['notificationType'] = notificationType;
    data['token'] = token;
    data['createdAt'] = createdAt;
    data['location'] = location;
    data['guide'] = guide?.toInt();
    return data;
  }

  MyIdentity copyWith({
    int? id,
    String? phoneNumber,
    String? name,
    String? imageUrl,
    String? token,
    String? fcmToken,
    String? location,
    String? email,
    String? createdAt,
    int? serverId,
    UserType? guide,
    int? notificationType,
  }) =>
      MyIdentity(
        id: id ?? this.id,
        serverId: serverId ?? this.serverId,
        notificationType: notificationType ?? this.notificationType,
        guide: guide ?? this.guide,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        token: token ?? this.token,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "phoneNumber": phoneNumber,
        "serverId": serverId,
        "imageUrl": imageUrl,
        "notificationType": notificationType,
        "name": name,
        "token": token,
        "location": location,
        "email": email,
        "guide": guide?.toInt(),
        "createdAt": createdAt,
      };

  factory MyIdentity.fromMap(Map<String, dynamic> json) => MyIdentity(
        id: json["id"],
        phoneNumber: json["phoneNumber"],
        serverId: json["serverId"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        notificationType: json["notificationType"],
        createdAt: json["createdAt"],
        guide: UserType.formInt(json["guide"]),
        email: json["email"],
        token: json["token"],
        location: json["location"],
      );
}
