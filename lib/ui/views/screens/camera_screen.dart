import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import '../../utility/crop.dart' as ImageX;
import '../../widgets/showDialog.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  CameraController controller;
  FlashMode flashsetting = FlashMode.off;
  var imagePath;
  var _fileSize;
  var cropImage;

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  _initialize() async {
    try {
      List<CameraDescription> cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.high);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        controller.setFlashMode(FlashMode.off);
        setState(() {});
      });
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        setupCamera(controller.description);
      }
    }

    print(controller.value);
  }

  _toggleTorch() {
    print('_toggleTorch');
    if (flashsetting == FlashMode.torch) {
      controller.setFlashMode(FlashMode.off);
      setState(() => flashsetting = FlashMode.off);
    } else {
      controller.setFlashMode(FlashMode.torch);
      setState(() => flashsetting = FlashMode.torch);
    }
  }

  _takePicture(ctx) async {
    print('_takePicture');
    var file = await controller.takePicture();
    if (flashsetting == FlashMode.torch) {
      controller.setFlashMode(FlashMode.off);
      setState(() => flashsetting = FlashMode.off);
    }
    var decodedImage =
        await decodeImageFromList(File(file.path).readAsBytesSync());
    print('decodedImage');
    print(decodedImage.width);
    print(decodedImage.height);

    // var decodedImagez = await decode(file.path);
    var ww = (decodedImage.width * 0.35).toInt();
    var hh = decodedImage.height - 80;
    var xx = 40;
    var yy = ((decodedImage.height / 2) - (decodedImage.height * 0.25)).toInt();
    print('x $xx y $yy w $ww h $hh');
    var decodedImageX = await ImageX.decodeImg(file.path);
    var croppedImage;
    if (Platform.isIOS) {
      croppedImage = ImageX.copyCrop2(decodedImageX, yy, xx, ww, hh);
    } else {
      croppedImage = ImageX.copyCrop2(decodedImageX, yy, xx, ww, hh);
    }
    setState(() {
      imagePath = file.path;
      _fileSize = decodedImage;
      cropImage = croppedImage;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulDialog(
          title: "Are you sure?",
          message: "Is this correct",
          img: ImageX.encodePNG(croppedImage),
          callback: (ea) => Navigator.of(ctx).pop(),
        );
      },
    );
  }

  void setupCamera(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        print('Hello error');
      }
    });

    try {
      await controller.initialize();
      // await controller.setFlashMode(flashsetting);
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
    //   return Container();
    // }
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              (controller == null || !controller.value.isInitialized)
                  ? Container()
                  : _cameraPreviewWidget(),
              Positioned(
                bottom: 80,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _toggleTorch(),
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: Colors.white,
                            ),
                            Text('Light',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _takePicture(context),
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            Text('Capture',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Waiting...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 1 / controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            CustomPaint(
              foregroundPainter: Paint(),
              child: CameraPreview(controller),
            ),
            ClipPath(clipper: Clip(), child: CameraPreview(controller)),
          ],
        ),
      );
    }
  }
}

cropB(size, num1, num2) {
  return {
    'x': num1,
    'y': (size.height / num2) - (size.height * (num2 / 4)),
    'w': size.width - (num1 * 2),
    'h': (size.width * (num2 / 2)),
  };
}

class Paint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey.withOpacity(0.8), BlendMode.dstOut);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Clip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    print('Clip $size');
    var size1 = cropB(size, 10, 2);
    print(size1);
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(40, (size.height / 2) - (size.height * 0.25),
              size.width - 80, (size.width * 0.35)),
// Rect.fromLTWH(size1['x'], size1['y'], size1['w'], size1['h']),
          Radius.circular(16)));
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return true;
  }
}
