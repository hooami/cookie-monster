import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

String generateRandomAlphanumeric() {
  final random = Random();
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ0123456789';
  String result = '';
  for (int i = 0; i < 6; i++) {
    result += chars[random.nextInt(chars.length)];
  }
  return result;
}

class InviteCode extends StatelessWidget {
  const InviteCode({super.key});

  @override
  Widget build(BuildContext context) {
    final String inviteCode = generateRandomAlphanumeric();
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.done, size: 80, color: const Color(0xff006ffd)),
            Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                '<Group Name> has been created!\n\n Share this invite code for others to join: ',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              inviteCode,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), 
            ElevatedButton.icon(
              onPressed: () {
                Share.share('Join my group with invite code: $inviteCode');
              },
              icon: const Icon(Icons.share),
              label: const Text('Share Code'),
            ),
          ],
        ),
      ),
    );
  }
}