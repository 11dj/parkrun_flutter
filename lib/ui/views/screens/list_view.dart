import 'package:flutter/material.dart';
import 'package:parkrun_app/packages.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isSearch = false;
  List mainDataList = [];
  List newDataList = [];
  ServerAPI _serverAPI = ServerAPI();

  @override
  void initState() {
    super.initState();
    _initialData();
    _searchController.addListener(_onchangeSearch);
  }

  _initialData() async {
    EasyLoading.show(status: 'loading...');
    try {
      var resp = await _serverAPI.getEventsList();
      var listx = resp['body']['getRaceVolunteer'];
      setState(() {
        mainDataList = listx;
        newDataList = List.from(mainDataList);
      });
      EasyLoading.dismiss();
    } catch (e) {
      print('ERR $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _onchangeSearch() {
    String value = _searchController.text;
    setState(() {
      newDataList = mainDataList
          .where((element) => element
              .toString()
              .toLowerCase()
              .contains(value.toString().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var styles = Theme.of(context);

    _clearSearch() {
      _searchController.clear();
      setState(() {
        isSearch = false;
      });
    }

    _logout() async {
      EasyLoading.show(status: 'loading...');
      await _serverAPI.signOut();
      EasyLoading.dismiss();
      Navigator.pop(context, 'login');
    }

    Drawer drawerx() => Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  Navigator.pop(context);
                  _logout();
                },
              ),
            ],
          ),
        );

    return Scaffold(
      // backgroundColor: styles.backgroundColor,
      appBar: AppBar(
        backgroundColor: styles.backgroundColor,
        title: Text('Park name list',
            style: styles.textTheme.headline4.copyWith(color: Colors.white)),
        actions: [
          if (!isSearch)
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => setState(() => isSearch = true),
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                    color: Colors.white,
                  ),
                )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => _logout(),
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      drawer: drawerx(),
      body: Column(
        children: [
          if (isSearch)
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 20.0),
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                  hintText: 'Enter a search park',
                  suffixIcon: IconButton(
                    onPressed: () => _clearSearch(),
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: newDataList.length,
              itemBuilder: (context, index) {
                var item = newDataList[index];

                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detail',
                      arguments: item['name']),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue,
                          height: 120,
                          width: double.infinity,
                          child: Image.network(
                            item['event']['image'],
                            fit: BoxFit.fill,
                            width: 240,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.0)),
                                  Text(
                                    ' คนเข้าร่วม 34/40',
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
