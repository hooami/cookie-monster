import 'package:app/models/db_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:collection/collection.dart';

class UserGroupSettingModel {
  String userId;
  int minutesBefore;
  bool shouldCreateAlarm;
  bool shouldIgnoreDnd;

  UserGroupSettingModel({
    required this.userId,
    required this.minutesBefore,
    this.shouldCreateAlarm = false,
    this.shouldIgnoreDnd = false,
  });

  static UserGroupSettingModel? _toModel(Map<String, dynamic>? settingMap) {
    if (settingMap == null) {
      return null;
    }

    return UserGroupSettingModel(
      userId: settingMap["userId"],
      minutesBefore: settingMap["minutesBefore"],
      shouldCreateAlarm: settingMap["shouldCreateAlarm"],
      shouldIgnoreDnd: settingMap["shouldIgnoreDnd"],
    );
  }

  toMap() {
    return {
      "userId": userId,
      "minutesBefore": minutesBefore,
      "shouldCreateAlarm": shouldCreateAlarm,
      "shouldIgnoreDnd": shouldIgnoreDnd,
    };
  }
}

class GroupModel {
  String uuid;
  String title;
  List<String> members;
  String timezone;
  String inviteCode;
  List<UserGroupSettingModel> userSettings = [];

  bool _isNew = true;

  GroupModel({
    required this.uuid,
    required this.title,
    required this.members,
    required this.timezone,
    required this.inviteCode,
    required this.userSettings,
  });

  static List<GroupModel> _myGroups = [];

  static Future<GroupModel?> getGroup(String groupId) async {
    await DbConstants.connect();
    return _toModel(
      await DbConstants.groups.findOne(where.eq("uuid", groupId)),
    );
  }

  static Future<GroupModel?> getGroupByInviteCode(String inviteCode) async {
    await DbConstants.connect();
    return _toModel(
      await DbConstants.groups.findOne(where.eq("inviteCode", inviteCode)),
    );
  }

  static Future<List<GroupModel>> getMyGroups(String userUuid) async {
    await DbConstants.connect();
    _myGroups = (await DbConstants.groups
            .find(where.eq("members", userUuid))
            .map((group) {
      var groupModel = _toModel(group);
      return groupModel;
    }).toList())
        .whereType<GroupModel>()
        .toList();
    return _myGroups;
  }

  static GroupModel? _toModel(Map<String, dynamic>? groupMap) {
    if (groupMap == null) {
      return null;
    }

    var groupModel = GroupModel(
      uuid: groupMap["uuid"],
      title: groupMap["title"],
      members: List<String>.from(groupMap["members"] as List),
      timezone: groupMap["timezone"],
      inviteCode: groupMap["inviteCode"],
      userSettings: List<Map<String, dynamic>>.from(
        (groupMap["userSettings"] ?? []) as List,
      )
          .map(UserGroupSettingModel._toModel)
          .whereType<UserGroupSettingModel>()
          .toList(),
    );
    groupModel._isNew = false;
    return groupModel;
  }

  Future<void> save() async {
    _validateSettings();
    await DbConstants.connect();
    if (_isNew) {
      await DbConstants.groups.insert(toMap());
    } else {
      await DbConstants.groups.replaceOne(where.eq("uuid", uuid), toMap());
    }
  }

  _validateSettings() {
    if (userSettings.length != members.length) {
      final memberSet = members.toSet();
      final settingSet = userSettings.map((s) => s.userId).toSet();
      memberSet.difference(settingSet).forEach((userId) {
        userSettings.add(UserGroupSettingModel(
          userId: userId,
          minutesBefore: 15,
        ));
      });
    }
  }

  void updateUserSettings(UserGroupSettingModel userSetting) {
    UserGroupSettingModel? oldSettings =
        userSettings.firstWhereOrNull((s) => s.userId == userSetting.userId);

    if (oldSettings == null) {
      userSettings.add(userSetting);
      return;
    }

    oldSettings.minutesBefore = userSetting.minutesBefore;
    oldSettings.shouldCreateAlarm = userSetting.shouldCreateAlarm;
    oldSettings.shouldIgnoreDnd = userSetting.shouldIgnoreDnd;
  }

  toMap() {
    return {
      "uuid": uuid,
      "title": title,
      "members": members,
      "timezone": timezone,
      "inviteCode": inviteCode,
      "userSettings": userSettings.map((x) => x.toMap()).toList(),
    };
  }
}
