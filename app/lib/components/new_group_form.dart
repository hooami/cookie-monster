import 'package:app/models/group.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';

// Create a Form widget.
class NewGroupForm extends StatefulWidget {
  final Function refreshParentPage;
  const NewGroupForm({
    super.key,
    required this.refreshParentPage,
  });

  @override
  NewGroupFormState createState() {
    return NewGroupFormState();
  }
}

class NewGroupFormState extends State<NewGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final groupNameController = TextEditingController();

  Future<void> _submitForm() async {
    var model = GroupModel(
      uuid: UuidV4().generate(),
      title: groupNameController.text,
      members: List.from(["32316851-0ffd-4643-88f8-cf035445ed40"]),
      timezone: "Asia/Singapore",
      inviteCode: UuidV4().generate(),
    );
    return await model.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(),
                child: TextFormField(
                  controller: groupNameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelText: 'Enter your group name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Group name must not be empty';
                    }
                    return null;
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _submitForm().then((void _) {
                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Successfully created group'),
                        ),
                      );

                      Navigator.pop(context);
                      widget.refreshParentPage();
                    }, onError: (void _) {
                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Failed to create group, please try again :('),
                        ),
                      );

                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ));
  }
}
