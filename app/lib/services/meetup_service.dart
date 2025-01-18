import 'package:app/models/alarm.dart';
import 'package:app/models/group.dart';
import 'package:app/models/meetup.dart';
import 'package:app/models/user.dart';
import 'package:collection/collection.dart';

class MeetupDisplayData {
  UserModel user;
  AlarmModel alarm;

  MeetupDisplayData({
    required this.user,
    required this.alarm,
  });
}

class MeetupPageData {
  GroupModel group;
  List<MeetupModel> meetups;
  List<AlarmModel> alarms;
  List<UserModel> users;

  MeetupPageData({
    required this.group,
    required this.meetups,
    required this.alarms,
    required this.users,
  });

  List<MeetupDisplayData> formatMeetupDisplay(MeetupModel meetup) {
    return users
        .map((user) {
          AlarmModel? alarm = alarms.firstWhereOrNull((alarm) =>
              alarm.meetupId == meetup.uuid && alarm.userId == user.uuid);

          if (alarm == null) {
            return null;
          }

          return MeetupDisplayData(
            user: user,
            alarm: alarm,
          );
        })
        .whereType<MeetupDisplayData>()
        .toList();
  }
}

class MeetupPageService {
  final GroupModel group;

  MeetupPageService({
    required this.group,
  });

  List<MeetupModel> meetups = [];
  List<AlarmModel> alarms = [];
  List<UserModel> users = [];

  Future<MeetupPageData> getData() async {
    final meetupsQuery = MeetupModel.getMeetupsByGroup(group.uuid);
    final alarmsQuery = AlarmModel.getAlarmsByGroup(group.uuid);
    final usersQuery = UserModel.getUsers(group.members);

    meetups = (await meetupsQuery);
    alarms = (await alarmsQuery);
    users = (await usersQuery);

    return MeetupPageData(
      group: group,
      meetups: meetups,
      alarms: alarms,
      users: users,
    );
  }
}
