import 'package:app/components/topbar.dart';
import 'package:flutter/material.dart';

class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(index: 0),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  filled: true,
                  fillColor: Color.fromRGBO(249, 249, 254, 1),
                  // fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                ),
              ),
            )
          ],
        ));
  }
}
