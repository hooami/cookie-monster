import 'dart:collection';

import 'package:app/components/topbar.dart';
import 'package:app/models/group.dart';
import 'package:flutter/material.dart';
import 'package:app/components/group_speed_dial.dart'; // Add this import

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final searchController = TextEditingController();
  bool initialised = false;
  List<GroupModel> _groups = [];
  UnmodifiableListView<GroupModel> displayGroups = UnmodifiableListView([]);

  @override
  void initState() {
    super.initState();
    searchController.addListener(_updateSearch);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _updateSearch() {
    setState(() {
      if (searchController.text == "") {
        displayGroups = UnmodifiableListView(_groups);
      } else {
        displayGroups = UnmodifiableListView(
          _groups.where((e) {
            return e.title.toLowerCase().contains(
                  searchController.text.toLowerCase(),
                );
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GroupModel.getMyGroups("32316851-0ffd-4643-88f8-cf035445ed40"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _initData(snapshot.data!);
            return _groupsBody(context, snapshot);
          }
          return const Scaffold();
        });
    ;
  }

  _initData(List<GroupModel?> groupModelList, {force = false}) {
    if (initialised && !force) {
      return;
    }

    initialised = true;
    _groups = groupModelList.whereType<GroupModel>().toList();
    displayGroups = UnmodifiableListView(_groups);
  }

  Future<void> _refreshPage() async {
    List<GroupModel?> groups =
        await GroupModel.getMyGroups("32316851-0ffd-4643-88f8-cf035445ed40");

    setState(() {
      _initData(
        groups,
        force: true,
      );
    });
  }

  Scaffold _groupsBody(
      BuildContext context, AsyncSnapshot<List<GroupModel?>> snapshot) {
    if (snapshot.data == null) {
      throw Exception("expected non-null");
    }

    return Scaffold(
      appBar: TopBar(index: 0),
      floatingActionButton: GroupSpeedDial(
        refreshParentPage: _refreshPage,
      ), // Add this line
      body: Column(
        children: [_searchInput(), _groupsList(context)],
      ),
    );
  }

  Widget _groupsList(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  TopBar(index: 0).preferredSize.height -
                  190,
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: displayGroups.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FF),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(displayGroups[index].title),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Add navigation
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 2,
                                  ),
                                  child:
                                      Icon(Icons.arrow_forward_ios, size: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _searchInput() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.search),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          fillColor: const Color.fromRGBO(249, 249, 254, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintText: 'Search',
        ),
      ),
    );
  }
}
