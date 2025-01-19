import 'package:app/components/topbar.dart';
import 'package:app/models/group.dart';
import 'package:flutter/material.dart';
import '../components/new_meetup_form.dart';

class AddMeetupPage extends StatelessWidget {
  final GroupModel group;
  final Function refreshMeetupPage;

  const AddMeetupPage({
    super.key,
    required this.group,
    required this.refreshMeetupPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(index: 2),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.all(20),
                child: NewMeetupForm(
                  group: group,
                  refreshMeetupPage: refreshMeetupPage,
                ))
          ],
        ));
  }
}
