import 'package:flutter/material.dart';

class ABCDEView extends StatefulWidget {
  ABCDEView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ABCDEViewState createState() => _ABCDEViewState();
}

class _ABCDEViewState extends State<ABCDEView> {
  @override
  Widget build(BuildContext context) {
    var styles = Theme.of(context);

    return Scaffold(
      backgroundColor: styles.backgroundColor,
      body: Center(
        child: Text('Blank screen', style: styles.textTheme.headline4),
      ),
    );
  }
}
