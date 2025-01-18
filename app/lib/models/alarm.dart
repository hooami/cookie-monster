import 'package:app/models/db_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AlarmModel {
  String uuid;
  String groupId;
  String meetupId;
  String userId;
  DateTime datetime;
  String sound;
  int snoozeCount;
  bool turnedOff;

  AlarmModel({
    required this.uuid,
    required this.groupId,
    required this.meetupId,
    required this.userId,
    required this.datetime,
    this.sound = "",
    this.snoozeCount = 0,
    this.turnedOff = false,
  });

  Future<void> insert() async {
    await DbConstants.connect();
    await DbConstants.alarms.insert(toMap());
  }

  static Future<List<AlarmModel>> getAlarmsByGroup(String groupId) async {
    await DbConstants.connect();
    return (await DbConstants.alarms.find(where.eq("groupId", groupId)).map(
      (alarm) {
        return _toModel(alarm);
      },
    ).toList())
        .whereType<AlarmModel>()
        .toList();
  }

  static AlarmModel? _toModel(Map<String, dynamic>? alarmMap) {
    if (alarmMap == null) {
      return null;
    }

    return AlarmModel(
      uuid: alarmMap["uuid"],
      groupId: alarmMap["groupId"],
      meetupId: alarmMap["meetupId"],
      userId: alarmMap["userId"],
      datetime: (alarmMap["datetime"] as DateTime).toLocal(),
      sound: alarmMap["sound"],
      snoozeCount: alarmMap["snoozeCount"],
      turnedOff: alarmMap["turnedOff"],
    );
  }

  toMap() {
    return {
      "uuid": uuid,
      "groupId": groupId,
      "meetupId": meetupId,
      "userId": userId,
      "datetime": datetime.toUtc(),
      "sound": sound,
      "snoozeCount": snoozeCount,
      "turnedOff": turnedOff,
    };
  }
}
