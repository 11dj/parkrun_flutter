import 'package:flutter/material.dart';
import 'package:parkrun_app/packages.dart';

class BranchListView extends StatefulWidget {
  BranchListView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BranchListViewState createState() => _BranchListViewState();
}

class _BranchListViewState extends State<BranchListView> {
  TextEditingController _searchController = TextEditingController();
  bool isSearch = false;
  static List<String> mainDataList = [];
  List<String> newDataList = [];

  @override
  void initState() {
    super.initState();
    _initialData();
    _searchController.addListener(_onchangeSearch);
  }

  _initialData() {
    EasyLoading.show(status: 'loading...');
    try {
      Timer(Duration(seconds: 1), () {
        setState(() {
          mainDataList =
              List<String>.generate(1000, (i) => i.toString().padLeft(4, '0'));
          newDataList = List.from(mainDataList);
        });
        EasyLoading.dismiss();
      });
    } catch (e) {}
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

    return Scaffold(
      // backgroundColor: styles.backgroundColor,
      appBar: AppBar(
        backgroundColor: styles.backgroundColor,
        title: Text('Department Store',
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
        ],
      ),
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
                  hintText: 'Enter a search ID/Branch',
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
                final item = newDataList[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detail',
                      arguments: 'Branch $item'),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0)),
                          Text(
                            ' Branch',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ],
                      ),
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
