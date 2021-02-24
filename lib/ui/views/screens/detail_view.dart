import 'package:flutter/material.dart';
import 'package:parkrun_app/packages.dart';

class DetailView extends StatefulWidget {
  DetailView({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
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
              List<String>.generate(20, (i) => i.toString().padLeft(4, '0'));
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

  _qrScan() async {
    var result = await Navigator.pushNamed(context, 'qr');
    print(result);
    if (result != null) {
      Navigator.pushNamed(context, 'meter');
    }
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
      body: Container(
        color: Colors.grey[200],
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: styles.backgroundColor,
              title: (!isSearch)
                  ? Text(
                      'Park Detail',
                      style: styles.textTheme.headline4
                          .copyWith(color: Colors.white),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20.0),
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          hintText: 'Search Any',
                          suffixIcon: IconButton(
                            onPressed: () => _clearSearch(),
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
              expandedHeight: 240,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                              child: Icon(Icons.pin_drop, color: Colors.white)),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                              child: Text(
                            widget.id,
                            style: styles.textTheme.headline6
                                .copyWith(color: Colors.white),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                              child: Icon(Icons.timer, color: Colors.white)),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                              child: Text(
                            '22/2/2021 07:00-08:00',
                            style: styles.textTheme.headline6
                                .copyWith(color: Colors.white),
                          )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 7,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 8.0, right: 4.0, bottom: 8.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        child: Icon(Icons.color_lens_outlined,
                                            color: Colors.white)),
                                    Padding(padding: EdgeInsets.all(5.0)),
                                    Container(
                                        child: Text(
                                      'จำนวนผู้เข้าร่วม',
                                      style: styles.textTheme.headline6
                                          .copyWith(color: Colors.white),
                                    ))
                                  ],
                                ),
                                Container(
                                    child: Text(
                                  newDataList.length.toString(),
                                  style: styles.textTheme.headline6
                                      .copyWith(color: Colors.white),
                                ))
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () => _qrScan(),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 4.0, right: 8.0, bottom: 8.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10.0) //         <--- border radius here
                                    ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      child: Icon(Icons.qr_code,
                                          color: Colors.white)),
                                  Padding(padding: EdgeInsets.all(5.0)),
                                  Container(
                                      child: Text(
                                    'แสกน',
                                    style: styles.textTheme.headline6
                                        .copyWith(color: Colors.white),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = mainDataList[index];
                  return Card(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
                      padding: EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('คนที่ $item',
                              style: styles.textTheme.headline6
                                  .copyWith(color: Colors.black)),
                          Padding(padding: EdgeInsets.all(3.0)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.one_k,
                                          color: Colors.blue,
                                        ),
                                        Padding(padding: EdgeInsets.all(4.0)),
                                        Text('Lap #1'),
                                      ],
                                    ),
                                    Text('00:15:00'),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.two_k,
                                          color: Colors.yellow[600],
                                        ),
                                        Padding(padding: EdgeInsets.all(4.0)),
                                        Text('Lap #2'),
                                      ],
                                    ),
                                    Text('00:30:00'),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.three_k,
                                          color: Colors.green,
                                        ),
                                        Padding(padding: EdgeInsets.all(4.0)),
                                        Text('Lap #3'),
                                      ],
                                    ),
                                    Text('00:45:00'),
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
                childCount: newDataList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  const DynamicSliverHeaderDelegate({
    @required this.child,
    this.maxHeight = 100,
    this.minHeight = 80,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  // @override
  // bool shouldRebuild(DynamicSliverHeaderDelegate oldDelegate) => true;

  @override
  bool shouldRebuild(DynamicSliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}
