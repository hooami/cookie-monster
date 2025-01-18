import 'package:app/components/topbar.dart';
import 'package:app/components/group_search_bar.dart';

import 'package:app/pages/add_group.dart';
import 'package:flutter/material.dart';

class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(index: 0),
      body: Column(
        children: [
          GroupSearchBar()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGroup()),
          );
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
