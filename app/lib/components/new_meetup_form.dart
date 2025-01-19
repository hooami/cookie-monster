import 'package:app/models/group.dart';
import 'package:app/models/meetup.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';

// Create a Form widget.
class NewMeetupForm extends StatefulWidget {
  final GroupModel group;
  final Function refreshMeetupPage;

  const NewMeetupForm({
    super.key,
    required this.group,
    required this.refreshMeetupPage,
  });

  @override
  NewMeetupFormState createState() {
    return NewMeetupFormState();
  }
}

class NewMeetupFormState extends State<NewMeetupForm> {
  TimeOfDay? _timeOfDay;
  DateTime? _date;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _submitForm() async {
    DateTime date = _date!.toLocal();
    date = DateTime(
      date.year,
      date.month,
      date.day,
      _timeOfDay!.hour,
      _timeOfDay!.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );

    var model = MeetupModel(
      uuid: UuidV4().generate(),
      groupId: widget.group.uuid,
      location: _locationController.text,
      datetime: date,
    );
    await model.insert();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Date',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  border: UnderlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Time',
                  filled: true,
                  prefixIcon: Icon(Icons.access_time_outlined),
                  border: UnderlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                readOnly: true,
                onTap: () {
                  _selectTime();
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Location',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location must not be empty';
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
                          content: Text('Successfully created meet-up'),
                        ),
                      );

                      Navigator.pop(context);
                      widget.refreshMeetupPage();
                    });
                  }
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ));
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 100)));

    if (_picked != null) {
      setState(() {
        _date = _picked;
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? _picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (_picked != null) {
      setState(() {
        _timeOfDay = _picked;
        _timeController.text = _picked.format(context);
      });
    }
  }
}
