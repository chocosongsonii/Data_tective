import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui show Image;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:touchable/touchable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

ImagePicker imagePicker = ImagePicker();

class ImageCover extends StatefulWidget {
  final List<Face> faces;
  final images;  // TODO: 안 쓰면 삭제 필요
  final ui.Image imageSelected;
  final _sticker;  // TODO: type 정의 필요
  ImageCover(this.faces, this.images, this.imageSelected, this._sticker);

  @override
  _ImageCoverState createState() => _ImageCoverState(faces, images, imageSelected, _sticker);
}

class _ImageCoverState extends State<ImageCover> {
  List<Face> faces;
  final images;
  ui.Image imageSelected;
  var _image;
  ui.Image coverimage;
  var _sticker;

  _ImageCoverState(this.faces, this.images, this.imageSelected, this._sticker);



  @override
  void initState() {
    super.initState();
    bringSticker();
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void bringSticker() async {
    _image = await getImageFileFromAssets('sticker'+_sticker.toString()+'.png');
  }

  void getImage() async {
    var imageFile = await _image.readAsBytes();
    ui.Image imageFile2 = await decodeImageFromList(imageFile);

    setState(() {
      coverimage = imageFile2;
    });
  }

  void getImage2() async {
    var imageFile = await _image.readAsBytes();
    ui.Image imageFile2 = await decodeImageFromList(imageFile);

    setState(() {
      _image = Image.asset('assets/sticker'+_sticker.toString()+'.png');
      coverimage = imageFile2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        elevation: 0,
        gradient: const LinearGradient(
            colors: [Color(0xff647dee), Color(0xff7f53ac)]
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset("assets/logo-white.png", width: 50,),
              const SizedBox(width: 10),
              Image.asset("assets/logo-text-white.png", width: 100)
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: getImage,
              child: const Text('검열', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            height: imageSelected.height.toDouble(),
            width: imageSelected.width.toDouble(),
            child: CanvasTouchDetector(
              builder: (context) => CustomPaint(
                painter: FaceDraw(context, faces, imageSelected, coverimage),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FaceDraw extends CustomPainter {
  List<Face> faces;
  ui.Image image;
  final BuildContext context;
  ui.Image coverImage;

  FaceDraw(this.context, this.faces, this.image, this.coverImage);

  @override

  void paint(Canvas canvas, Size size) {
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    touchyCanvas.drawImage(
        image,
        Offset.zero,
        Paint()
    );

    for (Face face in faces) {

      canvas.drawImageRect(
          coverImage,
          Offset.zero & Size(coverImage.width.toDouble(), coverImage.height.toDouble()),
          Offset(face.boundingBox.left, face.boundingBox.top) & Size(face.boundingBox.width, face.boundingBox.height),
          Paint());

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
