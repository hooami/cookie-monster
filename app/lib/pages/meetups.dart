import 'package:app/components/topbar.dart';
import 'package:app/models/group.dart';
import 'package:app/models/meetup.dart';

import 'package:app/pages/add_meetup.dart';
import 'package:app/services/meetup_service.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // Add this package for date formatting

class MeetupsPage extends StatefulWidget {
  final GroupModel group;

  const MeetupsPage({
    super.key,
    required this.group,
  });

  @override
  State<MeetupsPage> createState() => _MeetupsPageState();
}

class _MeetupsPageState extends State<MeetupsPage> {
  MeetupPageData? _data;

  bool initialised = false;

  final now = DateTime.now();

  final backgroundColors = [
    const Color(0xFFF8F9FE),
    const Color(0xFFFFE2E5),
    const Color(0xFFFFF4E4)
  ];

  final dateFormatter = DateFormat('EEE, dd MMM yyyy');
  final timeFormatter = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final service = MeetupPageService(group: widget.group);
    return FutureBuilder(
      future: service.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _initData(snapshot.data!);
          return _meetupsPageBody(context);
        }
        return Scaffold();
      },
    );
  }

  void _initData(MeetupPageData data, {force = false}) {
    if (initialised && !force) {
      return;
    }

    initialised = true;
    _data = data;
  }

  void _refreshMeetupPage() async {
    final service = MeetupPageService(group: widget.group);
    final data = await service.getData();
    setState(() {
      _initData(data, force: true);
    });
  }

  Scaffold _meetupsPageBody(BuildContext context) {
    List<MeetupModel> meetups = _data!.meetups;
    return Scaffold(
      appBar: TopBar(index: 3),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _data!.meetups.length,
            itemBuilder: (context, parentIndex) {
              final date = dateFormatter.format(meetups[parentIndex].datetime);
              final time = timeFormatter.format(meetups[parentIndex].datetime);
              final meetupData =
                  _data!.formatMeetupDisplay(meetups[parentIndex]);

              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' $date',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Color(0xffe8e9f1),
                      ),
                      child: ListTile(
                        leading: Text(time),
                        trailing: Text(meetups[parentIndex].location),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: meetupData.length,
                      itemBuilder: (context, childIndex) {
                        final color = backgroundColors[
                            childIndex % backgroundColors.length];

                        final displayData = meetupData[childIndex];
                        return Container(
                            color: color,
                            child: ListTile(
                              leading: Text(displayData.user.name),
                              title: Text(displayData.alarm.turnedOff
                                  ? "Awake"
                                  : "Snooze Count: ${displayData.alarm.snoozeCount}"),
                              trailing: Text(
                                timeFormatter
                                    .format(displayData.alarm.datetime),
                              ),
                            ));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMeetupPage(
                  group: widget.group, refreshMeetupPage: _refreshMeetupPage),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
