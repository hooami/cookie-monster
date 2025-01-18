import 'package:flutter/material.dart';

// Create a Form widget.
class NewGroupForm extends StatefulWidget {
  const NewGroupForm({super.key});

  @override
  NewGroupFormState createState() {
    return NewGroupFormState();
  }
}

class NewGroupFormState extends State<NewGroupForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric()
                , child: TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your group name'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Group name can not be empty';
                    }
                    return null;
                  },
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully created group')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        )
    );
  }
}