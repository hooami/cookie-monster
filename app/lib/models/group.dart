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

  static List<GroupModel?> _myGroups = [];

  static Future<List<GroupModel?>> getMyGroups(String userUuid) async {
    await DbConstants.connect();
    _myGroups = await DbConstants.groups
        .find(where.eq("members", userUuid))
        .map((group) {
      var groupModel = _toModel(group);
      return groupModel;
    }).toList();
    return _myGroups;
  }

  Future<void> insert() async {
    await DbConstants.connect();
    await DbConstants.groups.insert(toMap());
  }

  static GroupModel? _toModel(Map<String, dynamic>? groupMap) {
    if (groupMap == null) {
      return null;
    }

    return GroupModel(
      uuid: groupMap["uuid"],
      title: groupMap["title"],
      members: List<String>.from(groupMap["members"] as List),
      timezone: groupMap["timezone"],
      inviteCode: groupMap["inviteCode"],
    );
  }

  toMap() {
    return {
      uuid: uuid,
      title: title,
      members: members,
      timezone: timezone,
      inviteCode: inviteCode,
    };
  }
}
