import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

var timezonesDropdown =
    tz.timeZoneDatabase.locations.values.map((tz.Location location) {
  return DropdownMenuEntry(
    value: location.name,
    label: location.name,
  );
}).toList();

class GroupSettings extends StatefulWidget {
  const GroupSettings({super.key});

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final TextEditingController timeZoneController = TextEditingController();
  bool alarmEnabled = true;
  String? selectedTimeZone;
  int? selectedHour;
  int? selectedMinute;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Group Settings',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: DropdownMenu<String>(
            controller: timeZoneController,
            requestFocusOnTap: true,
            label: const Text('Time Zone'),
            onSelected: (String? timeZone) {
              setState(() {
                selectedTimeZone = timeZone;
              });
            },
            dropdownMenuEntries: timezonesDropdown,
          ),
        ),
        Text('Individual Settings',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alarm before meetups',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 12),
              Switch(
                value: alarmEnabled,
                onChanged: (bool value) {
                  setState(() {
                    alarmEnabled = value;
                  });
                },
              ),
            ],
          ),
        ),
        if (alarmEnabled)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hours Dropdown
                Expanded(
                  child: DropdownMenu<int>(
                    label: const Text('Hours'),
                    onSelected: (int? hour) {
                      setState(() {
                        selectedHour = hour;
                      });
                    },
                    dropdownMenuEntries: List.generate(
                      12,
                      (index) => DropdownMenuEntry<int>(
                        value: index,
                        label: '$index',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownMenu<int>(
                    label: const Text('Minutes'),
                    onSelected: (int? minute) {
                      setState(() {
                        selectedMinute = minute;
                      });
                    },
                    dropdownMenuEntries: List.generate(
                      60,
                      (index) => DropdownMenuEntry<int>(
                        value: index,
                        label: '$index',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
