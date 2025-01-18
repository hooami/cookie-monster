import 'package:flutter/material.dart';

class TopBarModel {
  String title;
  Widget? leadingWidget;
  List<Widget>? actionsWidget;

  TopBarModel({
    required this.title,
    this.leadingWidget,
    this.actionsWidget
  });

  static List<TopBarModel> options = [
    TopBarModel(title: "Groups"),
    TopBarModel(title: "New Group")
  ];
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar({
    super.key,
    required this.index,
  });

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);
  final int index;

  @override
  Widget build(BuildContext context) {
    TopBarModel topBarModel = TopBarModel.options[index];
    if (index == 1) {
      topBarModel.leadingWidget = IconButton(
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          }
      );
    }
    return AppBar(
      title: Text(topBarModel.title),
      centerTitle: true,
      leading: topBarModel.leadingWidget,
      actions: topBarModel.actionsWidget,
    );
  }
}
