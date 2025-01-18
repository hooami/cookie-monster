import 'package:app/components/topbar.dart';
import 'package:flutter/material.dart';

import '../components/new_group_form.dart';

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(index: 1),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: const NewGroupForm()
            )
          ],
        )
    );
  }
}
