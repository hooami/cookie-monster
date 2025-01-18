import 'package:app/components/topbar.dart';

import 'package:app/pages/add_meetup.dart';
import 'package:app/models/meetup.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // Add this package for date formatting

class MeetupsPage extends StatelessWidget {
  final String groupId;
  const MeetupsPage({super.key, required this.groupId});

  Future<List<MeetupModel?>> _fetchMeetups() async {
    try {
      return await MeetupModel.getMeetupsByGroup(groupId);
    } catch (e) {
      debugPrint('Error fetching meetups: $e');
      throw e; // Let FutureBuilder handle the error
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    
    final backgroundColors = [
      const Color(0xFFF8F9FE),
      const Color(0xFFFFE2E5),
      const Color(0xFFFFF4E4)
    ];

    final dateFormatter = DateFormat('EEE, dd MMM yyyy');

    return Scaffold(
      appBar: TopBar(index: 3),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, parentIndex) {
              final date =
                  dateFormatter.format(now.add(Duration(days: parentIndex)));

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
                        leading: Text('User $parentIndex'),
                        trailing:
                            Text('Details about Meetup $parentIndex\nabc'),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, childIndex) {
                        final color = backgroundColors[
                            childIndex % backgroundColors.length];

                        return Container(
                            color: color,
                            child: ListTile(
                              leading: Text('User $childIndex'),
                              title: Text('Meetup $childIndex'),
                              trailing:
                                  Text('Details about Meetup $childIndex\nabc'),
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
            MaterialPageRoute(builder: (context) => AddMeetupPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
