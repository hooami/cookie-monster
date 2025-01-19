import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmStandby extends StatelessWidget {
  const AlarmStandby ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child:FloatingActionButton(onPressed: saveAlarm()));
  }

  saveAlarm() {
    AlarmSettings buildAlarmSettings() {
      // final id = creating
      //     ? DateTime.now().millisecondsSinceEpoch % 10000 + 1
      //     : widget.alarmSettings!.id;
      final id = DateTime.now().millisecondsSinceEpoch % 10000 + 1;

      // final VolumeSettings volumeSettings;
      // if (staircaseFade) {
      //   volumeSettings = VolumeSettings.staircaseFade(
      //     volume: volume,
      //     fadeSteps: [
      //       VolumeFadeStep(Duration.zero, 0),
      //       VolumeFadeStep(const Duration(seconds: 15), 0.03),
      //       VolumeFadeStep(const Duration(seconds: 20), 0.5),
      //       VolumeFadeStep(const Duration(seconds: 30), 1),
      //     ],
      //   );
      // } else if (fadeDuration != null) {
      //   volumeSettings = VolumeSettings.fade(
      //     volume: volume,
      //     fadeDuration: fadeDuration!,
      //   );
      // } else {
      //   volumeSettings = VolumeSettings.fixed(volume: volume);
      // }

      final alarmSettings = AlarmSettings(
        id: id,
        dateTime: DateTime.now().add(Duration(minutes: 1)),
        //loopAudio: loopAudio,
        loopAudio: true,
        //vibrate: vibrate,
        vibrate: true,
        assetAudioPath: 'nokia.mp3',
        warningNotificationOnKill: Platform.isIOS,
        //volumeSettings: volumeSettings,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationSettings: NotificationSettings(
          title: 'Alarm example',
          body: 'Your alarm ($id) is ringing',
          stopButton: 'Stop the alarm',
          icon: 'notification_icon',
        ),
      );
      return alarmSettings;
    }
    Alarm.set(alarmSettings: buildAlarmSettings());
  }
}
