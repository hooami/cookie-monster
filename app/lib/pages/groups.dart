import 'package:app/components/topbar.dart';
import 'package:app/models/group.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GroupModel.getMyGroups("32316851-0ffd-4643-88f8-cf035445ed40"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _groupsBody(snapshot);
          }
          return Scaffold();
        });
  }

  Scaffold _groupsBody(AsyncSnapshot<List<GroupModel?>> snapshot) {
    List<GroupModel?>? groups = snapshot.data;
    print(groups.toString());
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
                  child: Icon(Icons.search),
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
      ),
    );
  }
}
