import 'package:app/components/topbar.dart';
import 'package:app/models/group.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GroupModel.getMyGroups("32316851-0ffd-4643-88f8-cf035445ed40"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _groupsBody(context, snapshot);
          }
          return Scaffold();
        });
  }

  Scaffold _groupsBody(
      BuildContext context, AsyncSnapshot<List<GroupModel?>> snapshot) {
    if (snapshot.data == null) {
      throw Exception("expected non-null");
    }

    List<GroupModel> groups =
        snapshot.data?.whereType<GroupModel>().toList() as List<GroupModel>;

    return Scaffold(
      appBar: TopBar(index: 0),
      body: Column(
        children: [_searchInput(), _groupsList(context, groups)],
      ),
    );
  }

  Widget _groupsList(BuildContext context, List<GroupModel> groups) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  TopBar(index: 0).preferredSize.height -
                  190,
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 15,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: groups.length,
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
                          padding: EdgeInsets.all(16),
                          height: 100,
                          decoration: BoxDecoration(
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
                              Text(groups[index].title),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Add navigation
                                },
                                child: Padding(
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
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.search),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
    );
  }
}
