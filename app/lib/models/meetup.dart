import 'package:app/models/db_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MeetupModel {
  String uuid;
  String groupId;
  String location;
  DateTime datetime;

  MeetupModel({
    required this.uuid,
    required this.groupId,
    required this.location,
    required this.datetime,
  });

  Future<void> insert() async {
    await DbConstants.connect();
    await DbConstants.meetups.insert(toMap());
  }

  static Future<List<MeetupModel?>> getMeetupsByGroup(String groupId) async {
    await DbConstants.connect();
    return await DbConstants.meetups
        .find(where.eq("groupId", groupId).sortBy("datetime", descending: true))
        .map((meetup) {
      return _toModel(meetup);
    }).toList();
  }

  static MeetupModel? _toModel(Map<String, dynamic>? meetupMap) {
    if (meetupMap == null) {
      return null;
    }

    return MeetupModel(
      uuid: meetupMap["uuid"],
      groupId: meetupMap["groupId"],
      location: meetupMap["location"],
      datetime: meetupMap["datetime"],
    );
  }

  toMap() {
    return {
      "uuid": uuid,
      "groupId": groupId,
      "location": location,
      "datetime": datetime,
    };
  }
}
