import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/pages/add_group.dart';
import 'package:app/components/group_dialog.dart';

class GroupSpeedDial extends StatelessWidget {
  final Function refreshParentPage;

  const GroupSpeedDial({
    super.key,
    required this.refreshParentPage,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Theme.of(context).primaryColor,
      spacing: 3,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.group_add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Create Group',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddGroupPage(
                  refreshParentPage: refreshParentPage,
                ),
              ),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.group),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          label: 'Join Group',
          onTap: () {
            JoinGroupDialog.show(context);
          },
        ),
      ],
    );
  }
}
