import 'package:travel_guide/core/storage/database/identity_database.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';

class AccountLocalDataSource {
  final IdentityDatabase _identityDatabase = IdentityDatabase();
  Future<MyIdentity?> getMyIdentity() async {
    return await _identityDatabase.getMyIdentity();
  }

  Future<bool> saveMyIdentity(MyIdentity identity) async {
    return await _identityDatabase.saveMyIdentity(identity);
  }

  Future<bool> deleteMyIdentity() async {
    return await _identityDatabase.deleteMyIdentity();
  }

  Future<bool> updateFcmToken(String fcm) async {
    return await _identityDatabase.updateFcmTokenInIdentity(fcm);
  }

  Future<bool> updateImage(String image) async {
    return await _identityDatabase.updateProfileImage(image);
  }

  Future<bool> updateNotificationSetting(int notificationSetting) async {
    return await _identityDatabase
        .updateNotificationSettings(notificationSetting);
  }

  Future<bool> updateName(String name) async {
    return await _identityDatabase.updateName(name);
  }
}
