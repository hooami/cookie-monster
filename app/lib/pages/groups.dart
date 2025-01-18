import 'package:app/components/topbar.dart';
import 'package:app/components/group_search_bar.dart';
import 'package:app/components/group_speed_dial.dart';

import 'package:flutter/material.dart';


class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(index: 0),
      body: Column(
        children: [
          GroupSearchBar()
        ],
      ),
      floatingActionButton: const GroupSpeedDial(),
    );
  }
}