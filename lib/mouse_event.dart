import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mouse extends StatefulWidget {
  @override
  _MouseState createState() => _MouseState();
}

class _MouseState extends State<Mouse> {
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 저장'),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: RepaintBoundary(
                key: _globalKey,
                child: Stack(
                  children: [
                    Flexible(child: Image.asset('assets/giyu.png')),
                    Positioned(
                      top: 100,
                      left: 100,
                      child: Center(
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.black.withOpacity(0),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: RaisedButton(
                onPressed: _saveScreen,
                child: Text("Save Local Image"),
              ),
              width: 200,
              height: 44,
            ),
          ],
        )
      ),
    );
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);
      _toastInfo(result.toString());
    }
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

}

class ImageGallerySaver {
  static const MethodChannel _channel =
  const MethodChannel('image_gallery_saver');

  /// save image to Gallery
  /// imageBytes can't null
  /// return Map type
  /// for example:{"isSuccess":true, "filePath":String?}
  static FutureOr<dynamic> saveImage(Uint8List imageBytes,
      {int quality = 80,
        String name,
        bool isReturnImagePathOfIOS = false}) async {
    assert(imageBytes != null);
    final result =
    await _channel.invokeMethod('saveImageToGallery', <String, dynamic>{
      'imageBytes': imageBytes,
      'quality': quality,
      'name': name,
      'isReturnImagePathOfIOS': isReturnImagePathOfIOS
    });
    return result;
  }

  /// Save the PNG，JPG，JPEG image or video located at [file] to the local device media gallery.
  static Future saveFile(String file, {String name, bool isReturnPathOfIOS = false}) async {
    assert(file != null);
    final result = await _channel.invokeMethod(
        'saveFileToGallery', <String, dynamic>{
      'file': file,
      'name': name,
      'isReturnPathOfIOS': isReturnPathOfIOS
    });
    return result;
  }
}