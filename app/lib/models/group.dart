import 'package:app/models/db_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class GroupModel {
  String uuid;
  String title;
  List<String> members;
  String timezone;
  String inviteCode;

  GroupModel({
    required this.uuid,
    required this.title,
    required this.members,
    required this.timezone,
    required this.inviteCode,
  });

  static List<GroupModel> _myGroups = [];

  static Future<List<GroupModel>> getMyGroups(String userUuid) async {
    await DbConstants.connect();
    _myGroups =
        await DbConstants.groups.find(where.eq("members", userUuid)).map(
      (group) {
        return GroupModel(
          uuid: group["uuid"],
          title: group["title"],
          members: List<String>.from(group["members"] as List),
          timezone: group["timezone"],
          inviteCode: group["inviteCode"],
        );
      },
    ).toList();
    return _myGroups;
  }
}
