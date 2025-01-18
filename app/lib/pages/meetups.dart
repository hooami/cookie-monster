import 'package:app/components/topbar.dart';
import 'package:app/pages/add_meetup.dart';
import 'package:flutter/material.dart';

class MeetupsPage extends StatelessWidget {
  const MeetupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(index: 2),
      body: Column(
        children: [
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMeetupPage()),
          );
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
