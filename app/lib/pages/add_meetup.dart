import 'package:app/components/topbar.dart';
import 'package:flutter/material.dart';

import '../components/new_meetup_form.dart';

class AddMeetupPage extends StatelessWidget {
  const AddMeetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(index: 2),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: const NewMeetupForm()
            )
          ],
        )
    );
  }
}
