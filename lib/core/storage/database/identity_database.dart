import 'package:sqflite/sqlite_api.dart';
import 'package:travel_guide/core/storage/database/database.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';

class IdentityDatabase {
  static final IdentityDatabase _instance = IdentityDatabase.internal();

  factory IdentityDatabase() => _instance;

  IdentityDatabase.internal();

  final SettAlKolDatabase _settAlKolDatabase = SettAlKolDatabase();

  Future<MyIdentity?> getMyIdentity() async {
    Database db = await _settAlKolDatabase.initDB();
    var res = await db.rawQuery(
      'SELECT * '
      'From ${SettAlKolDatabase.kIdentity} ',
    );
    return res.isNotEmpty
        ? res.map((user) => MyIdentity.fromMap(user)).first
        : null;
  }

  deleteMyIdentity() async {
    Database db = await _settAlKolDatabase.initDB();
    await db.delete(SettAlKolDatabase.kIdentity);
  }

  Future<bool> saveMyIdentity(MyIdentity identity) async {
    Database db = await _settAlKolDatabase.initDB();
    final getIdentityRes = await getMyIdentity();
    int res = 0;
    if (getIdentityRes != null) {
      res = await db.update(SettAlKolDatabase.kIdentity, identity.toMap());
    } else {
      res = await db.insert(SettAlKolDatabase.kIdentity, identity.toMap());
    }
    if (res != 0) return true;
    return false;
  }

  Future<bool> updateFcmTokenInIdentity(String fcm) async {
    Database db = await _settAlKolDatabase.initDB();
    final res = await db.rawUpdate(
      'UPDATE ${SettAlKolDatabase.kIdentity} SET fcmToken = ? ',
      [fcm],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateProfileImage(String image) async {
    Database db = await _settAlKolDatabase.initDB();
    final res = await db.rawUpdate(
      'UPDATE ${SettAlKolDatabase.kIdentity} SET imageUrl = ? ',
      [image],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateNotificationSettings(int notificationSetting) async {
    Database db = await _settAlKolDatabase.initDB();
    final res = await db.rawUpdate(
      'UPDATE ${SettAlKolDatabase.kIdentity} SET notificationType = ? ',
      [notificationSetting],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateName(String name) async {
    Database db = await _settAlKolDatabase.initDB();
    final res = await db.rawUpdate(
      'UPDATE ${SettAlKolDatabase.kIdentity} SET name = ? ',
      [name],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }
}
