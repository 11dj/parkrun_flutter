import 'dart:io';
import 'package:parkrun_app/packages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';
import 'package:flutter_beep/flutter_beep.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool f = false;
  List usedList = [];

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  didChangeDependencies() async {
    print(result);
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // void showInSnackBar(String message) {
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    // }

    _onDone() {
      Navigator.of(context).pop();
    }

    Widget _buildQrView(BuildContext context) {
      var scanArea = (MediaQuery.of(context).size.width < 400 ||
              MediaQuery.of(context).size.height < 400)
          ? 118.0
          : 236.0;
      _processQRScan(scanData) async {
        if (scanData.code == result?.code) return;
        var usedListx = usedList.map((e) => e['id']);
        if (usedListx.contains(scanData.code)) return;
        FlutterBeep.beep();
        print(scanData.code);
        print('result.code ${result?.code}');
        var now = new DateTime.now();
        setState(() {
          result = scanData;
          usedList.add({'id': scanData.code, 'time': now});
        });
        // showInSnackBar('ggggg');
        await Future.delayed(Duration(seconds: 3));
        setState(() {
          result = null;
        });
        print('ready');
      }

      void _onQRViewCreated(QRViewController controller) {
        setState(() {
          this.controller = controller;
        });
        controller.scannedDataStream
            .listen((scanData) async => _processQRScan(scanData));
      }

      return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildQrView(context),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                  Positioned(
                    bottom: 16,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                            child: Center(
                                child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text(
                                    'Flash :${(snapshot.data != null && snapshot.data) ? 'Off' : 'On'}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold));
                              },
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _onDone(),
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Center(
                                child: Text('Done',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text('check-in records',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Expanded(
            flex: 2,
            child: (usedList.length > 0)
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    itemCount: usedList.length,
                    itemBuilder: (context, index) {
                      String textId =
                          usedList[usedList.length - index - 1]['id'];
                      String textIdx =
                          '. . . .${textId.substring(textId.length - 8)}';
                      var time = usedList[usedList.length - index - 1]['time'];
                      String formattedDate =
                          DateFormat('kk:mm:ss').format(time);
                      return Card(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    (usedList.length - index).toString(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Container(
                                    width: 150,
                                    child: Text(textIdx,
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: 150,
                                      child: Text(formattedDate,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              )));
                    },
                  )
                : Center(
                    child: Text('No data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        )),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
