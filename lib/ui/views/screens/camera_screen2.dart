import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController controller;
  FlashMode flashsetting = FlashMode.off;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<CameraDescription> cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.setFlashMode(flashsetting);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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

  _takePicture() async {
    var file = await controller.takePicture();
    // var file2 = _cropImage(file?.path);
    print('yyyuuu $file');
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // AspectRatio(
                //     aspectRatio: 1 / controller.value.aspectRatio,
                //     child: CameraPreview(controller)),
                AspectRatio(
                  aspectRatio: 1 / controller.value.aspectRatio,
                  child: Stack(
                    children: <Widget>[
                      CustomPaint(
                        foregroundPainter: Paint(),
                        child: CameraPreview(controller),
                      ),
                      ClipPath(
                          clipper: Clip(), child: CameraPreview(controller)),
                    ],
                  ),
                ),
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
                        onTap: () => _takePicture(),
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
      ),
    );
  }
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
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(10, (size.height / 2) - (size.height * 0.25),
              size.width - 20, (size.width * 0.5)),
          Radius.circular(16)));
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return true;
  }
}
