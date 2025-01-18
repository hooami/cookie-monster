import 'package:flutter/material.dart';

class TopBarModel {
  String title;
  Widget? leadingWidget;
  GestureTapCallback? leadingCallback;
  Widget? trailingWidget;
  GestureTapCallback? trailingCallback;

  TopBarModel({
    required this.title,
    this.leadingWidget,
    this.leadingCallback,
    this.trailingWidget,
    this.trailingCallback,
  });

  static List<TopBarModel> options = [
    TopBarModel(title: "Groups"),
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
    return AppBar(
      title: Text(topBarModel.title),
      centerTitle: true,
      leading: topBarModel.leadingWidget != null
          ? GestureDetector(
              onTap: topBarModel.leadingCallback,
              child: topBarModel.leadingWidget,
            )
          : null,
    );
  }
}
