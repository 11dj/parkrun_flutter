import 'package:flutter/material.dart';

class MeterDetailView extends StatefulWidget {
  MeterDetailView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MeterDetailViewState createState() => _MeterDetailViewState();
}

class _MeterDetailViewState extends State<MeterDetailView> {
  @override
  Widget build(BuildContext context) {
    var styles = Theme.of(context);
    final TextStyle textstyleBtn = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0);
    inputStyle(text) {
      final InputDecoration decoration = InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey));
      return decoration;
    }

    return Scaffold(
      backgroundColor: styles.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                MaterialButton(
                  minWidth: 120,
                  child: Text(
                    'Back',
                    style:
                        styles.textTheme.button.copyWith(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.electrical_services,
                          size: 150,
                          color: Colors.white,
                        ),
                        Text('Electivity',
                            style: styles.textTheme.headline4
                                .copyWith(color: Colors.white)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Meter No.',
                                style: styles.textTheme.headline4
                                    .copyWith(color: Colors.white)),
                            Text('ABCD1234',
                                style: styles.textTheme.headline4
                                    .copyWith(color: Colors.white))
                          ],
                        ),
                        Divider(color: Colors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Branch',
                                style: styles.textTheme.headline4
                                    .copyWith(color: Colors.white)),
                            Text('Ladprao 1',
                                style: styles.textTheme.headline4
                                    .copyWith(color: Colors.white))
                          ],
                        ),
                        Divider(color: Colors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shop',
                                style: styles.textTheme.headline4
                                    .copyWith(color: Colors.white)),
                            Text('KFC',
                                style: styles.textTheme.headline4
                                    .copyWith(color: Colors.white))
                          ],
                        ),
                        Divider(color: Colors.white),
                        // TextFormField(
                        //   // controller: _controllerUsername,
                        //   style: TextStyle(color: Colors.white),
                        //   decoration: inputStyle('Username'),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                // controller: _controllerUsername,
                                style: TextStyle(color: Colors.white),
                                decoration: inputStyle('Meter value'),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: MaterialButton(
                                  // minWidth: 120,
                                  padding: EdgeInsets.all(10.0),
                                  color: Colors.blue,
                                  child: Text(
                                    'Scan',
                                    style: textstyleBtn,
                                  ),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, 'camera'),
                                ))
                            // Text('KFC',
                            //     style: styles.textTheme.headline4
                            //         .copyWith(color: Colors.white))
                          ],
                        ),
                        Divider(color: Colors.white)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      // minWidth: 120,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.blue,
                      child: Text(
                        'Comfirm',
                        style: textstyleBtn,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
