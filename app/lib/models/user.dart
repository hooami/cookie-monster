import 'package:app/models/db_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserModel {
  String uuid;
  String name;

  UserModel({
    required this.uuid,
    required this.name,
  });

  static Future<UserModel?> getUser(String uuid) async {
    await DbConstants.connect();
    var userMap = await DbConstants.users.findOne(where.eq("uuid", uuid));
    return _toModel(userMap);
  }

  static UserModel? _toModel(Map<String, dynamic>? userMap) {
    if (userMap == null) {
      return null;
    }

    return UserModel(
      uuid: userMap["uuid"],
      name: userMap["name"],
    );
  }
}
