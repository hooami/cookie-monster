import 'package:flutter/material.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({super.key});

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final TextEditingController timeZoneController = TextEditingController();
  bool alarmEnabled = true;
  int? selectedTimeZone;
  int? selectedHour;
  int? selectedMinute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Group Settings',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DropdownMenu<int>(
                controller: timeZoneController,
                requestFocusOnTap: true,
                label: const Text('Time Zone'),
                onSelected: (int? timeZone) {
                  setState(() {
                    selectedTimeZone = timeZone;
                  });
                },
                dropdownMenuEntries: const [
                  DropdownMenuEntry<int>(
                    value: 7,
                    label: 'Thailand (GMT+7)',
                  ),
                  DropdownMenuEntry<int>(
                    value: 8,
                    label: 'Singapore (GMT+8)',
                  ),
                  DropdownMenuEntry<int>(
                    value: 9,
                    label: 'Japan (GMT+9)',
                  ),
                  DropdownMenuEntry<int>(
                    value: 10,
                    label: 'Brisbane (GMT+10)',
                  ),
                  DropdownMenuEntry<int>(
                    value: 11,
                    label: 'Sydney (GMT+11)',
                  ),
                ],
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
        ),
      ),
    );
  }
}
