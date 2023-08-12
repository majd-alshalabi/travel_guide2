import 'package:flutter/material.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';

class AppSettings {
  static final AppSettings _instance = AppSettings._internal();

  factory AppSettings() {
    return _instance;
  }
  AppSettings._internal();

  MyIdentity? identity;
  String fcmToken = '';
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
