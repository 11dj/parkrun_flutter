import 'dart:io';
import 'package:parkrun_app/packages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
  BuildContext scaffoldContext;
  List usedList = [];

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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

  @override
  Widget build(BuildContext context) {
    scaffoldContext = context;
    // setState(() {
    //   scaffoldContext = context;
    // });

    void createSnackBar(String message) {
      final snackBar = new SnackBar(
          content: new Text(message), backgroundColor: Colors.black);

      Scaffold.of(context).showSnackBar(snackBar);
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print(result);
    //   if (result != null) createSnackBar('Hello');
    // });

    Widget _buildQrView(BuildContext context) {
      // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
      var scanArea = (MediaQuery.of(context).size.width < 400 ||
              MediaQuery.of(context).size.height < 400)
          ? 144.0
          : 288.0;
      // To ensure the Scanner view is properly sizes after rotation
      // we need to listen for Flutter SizeChanged notification and update controller
      _processX(scanData) async {
        if (scanData.code == result?.code) return;
        if (usedList.contains(scanData.code)) return;
        // print('${scanData.code} is used');
        print(scanData.code);
        print('result.code ${result?.code}');
        setState(() {
          result = scanData;
          usedList.add(scanData.code);
        });
        // Scaffold.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Sample snackbar'),
        //   ),
        // );
        createSnackBar('tttt');
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
        // controller.scannedDataStream.
        controller.scannedDataStream
            .listen((scanData) async => _processX(scanData));
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
      body: Column(
        children: <Widget>[
          Expanded(
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
                bottom: 100,
                child: GestureDetector(
                  onTap: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  child: Container(
                    height: 60,
                    width: 200,
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
              ),
              // FutureBuilder(
              //   future: result,
              //   builder: (context, snapshot) {
              //   return SnackBar(
              //       content: new Text('Hello'), backgroundColor: Colors.black);
              // })
            ],
          )),
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
