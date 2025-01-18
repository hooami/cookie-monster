import 'package:app/models/alarm.dart';
import 'package:app/models/group.dart';
import 'package:app/models/meetup.dart';
import 'package:app/models/user.dart';

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
}

class MeetupPageService {
  String groupId;

  MeetupPageService({
    required this.groupId,
  });

  GroupModel? group;
  List<MeetupModel> meetups = [];
  List<AlarmModel> alarms = [];
  List<UserModel> users = [];

  Future<MeetupPageData> getData() async {
    group = await GroupModel.getGroup(groupId);
    meetups = (await MeetupModel.getMeetupsByGroup(groupId))
        .whereType<MeetupModel>()
        .toList();
    alarms = (await AlarmModel.getAlarmsByGroup(groupId))
        .whereType<AlarmModel>()
        .toList();
    users = (await UserModel.getUsers(group!.members))
        .whereType<UserModel>()
        .toList();

    return MeetupPageData(
      group: group!,
      meetups: meetups,
      alarms: alarms,
      users: users,
    );
  }
}
