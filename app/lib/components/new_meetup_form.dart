import 'package:flutter/material.dart';

// Create a Form widget.
class NewMeetupForm extends StatefulWidget {
  const NewMeetupForm({super.key});

  @override
  NewMeetupFormState createState() {
    return NewMeetupFormState();
  }
}

class NewMeetupFormState extends State<NewMeetupForm> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

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
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
                readOnly: true,
                onTap: (){
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
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
                readOnly: true,
                onTap: (){
                  _selectTime();
                },
              ),
            ),
           
            Padding(padding: const EdgeInsets.symmetric(vertical: 16)
                , child: TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Location',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                  )
                  , validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location must not be empty';
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
                      const SnackBar(content: Text('Successfully created meet-up')),
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

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 365*100))
    );

    if (_picked != null){
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future <void> _selectTime() async {
   TimeOfDay ? _picked = await showTimePicker(
      initialTime: _timeOfDay,
      context: context
    );
    
    if(_picked != null){
      setState(() {
        _timeOfDay = _picked;
        _timeController.text = _timeOfDay.format(context);
      }); 
    }
  }
}