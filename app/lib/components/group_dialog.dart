import 'package:app/models/group.dart';
import 'package:flutter/material.dart';

class JoinGroupDialog {
  static void show(BuildContext context, Function refreshParentPage) {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Join Group',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Group Code',
                    hintText: 'e.g., ABC123',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        // TODO: DB CALL GOES HERE
                        final groupCode = codeController.text;
                        GroupModel? group =
                            await GroupModel.getGroupByInviteCode(groupCode);

                        if (!context.mounted) {
                          return;
                        }

                        if (group == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to join group'),
                            ),
                          );
                          Navigator.pop(context);
                          return;
                        }

                        group.members
                            .add("32316851-0ffd-4643-88f8-cf035445ed40");
                        await group.save();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Successfully joined group'),
                          ),
                        );
                        refreshParentPage();
                        Navigator.pop(context);
                      },
                      child: const Text('Join'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
