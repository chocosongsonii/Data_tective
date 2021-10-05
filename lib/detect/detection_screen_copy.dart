import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

class DetectionScreen extends StatefulWidget {
  final File imageFile;
  const DetectionScreen(this.imageFile);

  @override
  _DetectionScreenState createState() => _DetectionScreenState(imageFile);
}

class _DetectionScreenState extends State<DetectionScreen> {

  File imageFile;
  _DetectionScreenState(this.imageFile);

  ui.Image imageImage;
  List<Face> faces = [];
  List<TextBlock> textBlocks = [];
  List<TextLine> textLines = [];
  List <TextLine> toRemoveTextLine = [];
  List<Face> toRemoveFace = [];
  List<Rect> added = [];

  double _sigma = 5;

  bool blurVisibility = true;
  bool stickerVisibility = false;

  int selectedIndex = 0;

  int _stickerId = 1;

  String num;
  String textStr;

  ui.Image stickerImage;
  dynamic _stickerImage;

  Offset _start;
  Offset _end;

  double xStart = 0.0;
  double xEnd = 0.0;
  double yStart = 0.0;
  double yEnd = 0.0;

  double appBarHeight = AppBar().preferredSize.height;

  double imageScale = 0.0;

  double widthSum = 0;
  double widthAverage = 0;

  @override
  void initState() {
    super.initState();
    getImage();
    bringSticker();
  }

  void _blurShow() {
    setState(() {
      blurVisibility = true;
    });
  }
  void _blurHide() {
    setState(() {
      blurVisibility = false;
    });
  }

  void _stickerShow() {
    setState(() {
      stickerVisibility = true;
    });
  }
  void _stickerHide() {
    setState(() {
      stickerVisibility = false;
    });
  }

  void getImage() async {
    var imageFile3 = await imageFile.readAsBytes();
    ui.Image imageFile2 = await decodeImageFromList(imageFile3);

    final InputImage inputImage = InputImage.fromFilePath(imageFile.path);
    final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
    ));
    final TextDetector textDetector = GoogleMlKit.vision.textDetector();

    final List<Face> outputFaces = await faceDetector.processImage(inputImage);
    final recognisedText = await textDetector.processImage(inputImage);
    final List<TextBlock> outputBlocks = recognisedText.blocks;

    setState(() {
      imageImage = imageFile2;
      faces = outputFaces;
      textBlocks = outputBlocks;
      for(TextBlock block in textBlocks) {
        for (TextLine line in block.lines) {
          textLines.add(line);
        }
      }
      for (var element in textLines) {
        textStr = element.text;
        num = textStr.replaceAll(RegExp(r'[^0-9]'), '');
        if (num.length < 6) {
          toRemoveTextLine.add(element);
        }
      }
      textLines.removeWhere((element) => toRemoveTextLine.contains(element));

      if (imageImage.height/imageImage.width <= (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBarHeight-80)*15/21/(MediaQuery.of(context).size.width)) {
        imageScale = MediaQuery.of(context).size.width/imageImage.width;
      }
      else if (imageImage.height/imageImage.width > (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBarHeight-80)*15/21/(MediaQuery.of(context).size.width)) {
        imageScale = (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBarHeight-80)*15/21/imageImage.height;
      }

      if (faces.length <= 1) {
        faces.clear();
      }

      for (Face face in faces) {
        widthSum += face.boundingBox.width;
        widthAverage = widthSum/faces.length;
        // if (face.boundingBox.width > widthAverage*1.2) {
        //   toRemoveFace.add(face);
        // }
      }
      for (Face face in faces) {
        if (face.boundingBox.width > widthAverage*1.2) {
          toRemoveFace.add(face);
        }
      }
      faces.removeWhere((face) => toRemoveFace.contains(face));

      // for (Face face in faces) {
      //   removeFace(face);
      // }

    });
  }

  // void removeFace(Face face) {
  //   if (face.boundingBox.width >= widthAverage*0.8) {
  //     faces.remove(face);
  //   }
  // }

  static const List<Map<String, dynamic>> stickers = <Map<String, dynamic>>[ //TODO: 스티커 추가하기 (예영)
    <String, dynamic>{
      'name': 'Bear',
      'img': 'assets/sticker1.png',
    },
    <String, dynamic>{
      'name': 'Pig',
      'img': 'assets/sticker2.png',
    },
    <String, dynamic>{
      'name': 'Tiger',
      'img': 'assets/sticker3.png',
    },
    <String, dynamic>{
      'name': 'Rabbit',
      'img': 'assets/sticker4.png',
    },
    <String, dynamic>{
      'name': 'larva',
      'img': 'assets/sticker5.png',
    },
    <String, dynamic>{
      'name': 'Cat',
      'img': 'assets/sticker6.png',
    },
    <String, dynamic>{
      'name': 'Squirrel',
      'img': 'assets/sticker7.png',
    },
    <String, dynamic>{
      'name': 'Han1',
      'img': 'assets/sticker8.png',
    },
    <String, dynamic>{
      'name': 'Han2',
      'img': 'assets/sticker9.png',
    },
    <String, dynamic>{
      'name': 'Han3',
      'img': 'assets/sticker10.png',
    },
    <String, dynamic>{
      'name': 'Han4',
      'img': 'assets/sticker11.png',
    },
    <String, dynamic>{
      'name': 'Han5',
      'img': 'assets/sticker12.png',
    },
    <String, dynamic>{
      'name': 'Han6',
      'img': 'assets/sticker13.png',
    },
    <String, dynamic>{
      'name': 'Han7',
      'img': 'assets/sticker14.png',
    },
    <String, dynamic>{
      'name': 'Han8',
      'img': 'assets/sticker15.png',
    },
    <String, dynamic>{
      'name': 'Han9',
      'img': 'assets/sticker16.png',
    },
    <String, dynamic>{
      'name': 'Han10',
      'img': 'assets/sticker17.png',
    },
    <String, dynamic>{
      'name': 'Han11',
      'img': 'assets/sticker18.png',
    },
    <String, dynamic>{
      'name': 'Han12',
      'img': 'assets/sticker19.png',
    },
    <String, dynamic>{
      'name': 'Han13',
      'img': 'assets/sticker20.png',
    },
    <String, dynamic>{
      'name': 'Han14',
      'img': 'assets/sticker21.png',
    },
    <String, dynamic>{
      'name': 'Han15',
      'img': 'assets/sticker22.png',
    },
    <String, dynamic>{
      'name': 'Han16',
      'img': 'assets/sticker23.png',
    },
    <String, dynamic>{
      'name': 'Han17',
      'img': 'assets/sticker24.png',
    },
    <String, dynamic>{
      'name': 'Han18',
      'img': 'assets/sticker25.png',
    },
    <String, dynamic>{
      'name': 'Han19',
      'img': 'assets/sticker26.png',
    },
    <String, dynamic>{
      'name': 'Han20',
      'img': 'assets/sticker27.png',
    },
    <String, dynamic>{
      'name': 'Han21',
      'img': 'assets/sticker28.png',
    },
    <String, dynamic>{
      'name': 'Han22',
      'img': 'assets/sticker29.png',
    },
    <String, dynamic>{
      'name': 'Han23',
      'img': 'assets/sticker30.png',
    },
    <String, dynamic>{
      'name': 'Han24',
      'img': 'assets/sticker31.png',
    },
    <String, dynamic>{
      'name': 'white circle',
      'img': 'assets/sticker32.png',
    },
    <String, dynamic>{
      'name': ' gray circle',
      'img': 'assets/sticker33.png',
    },
    <String, dynamic>{
      'name': 'black circle',
      'img': 'assets/sticker34.png',
    },
    <String, dynamic>{
      'name': 'black rectangle',
      'img': 'assets/sticker35.jpg',
    },
  ];

  void checkOption(int index) {
    setState(() {
      _stickerId = index;
    });
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void bringSticker() async {
    setState(() async {
      _stickerImage = await getImageFileFromAssets('sticker'+_stickerId.toString()+'.png');
    });
  }

  void convertImageType() async {
    var imageFile = await _stickerImage.readAsBytes();
    ui.Image imageFile2 = await decodeImageFromList(imageFile);

    setState(() {
      stickerImage = imageFile2;
    });
  }

  void _scaleStartGesture(ScaleStartDetails onStart) {
    setState(() {
      _start = onStart.focalPoint;
      xStart = _start.dx;
      yStart = _start.dy;
    });
  }

  void _scaleUpdateGesture(ScaleUpdateDetails onUpdate) {
    setState(
          () {
        _start ??= onUpdate.focalPoint;
        _end = onUpdate.focalPoint;
        xEnd = _end.dx;
        yEnd = _end.dy;
      },
    );
  }

  void _scaleEndGesture(ScaleEndDetails onEnd) {
    setState(() {
      added.add(Rect.fromLTRB(
          (xStart-(MediaQuery.of(context).size.width-imageImage.width*imageScale)/2)/imageScale,
          (yStart-(MediaQuery.of(context).padding.top+appBarHeight+30+(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBarHeight-MediaQuery.of(context).padding.bottom-80)*3/21))/imageScale,
          (xEnd-(MediaQuery.of(context).size.width-imageImage.width*imageScale)/2)/imageScale,
          (yEnd-(MediaQuery.of(context).padding.top+appBarHeight+30+(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBarHeight-MediaQuery.of(context).padding.bottom-80)*3/21))/imageScale,
      ));
      for (Rect rect in added) {
        if (rect.height<=0) {
          added.remove(rect);
        }
        else if (rect.width<=0) {
          added.remove(rect);
        }
      }
    });
  }

  launchWebView(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    }
  }

  Column columnForBlur() {
    return Column(
      children: [
        Flexible(
          flex: 15,
          child: InteractiveViewer(
            // minScale: 0.1,
            // maxScale: 5,
            onInteractionStart: (ScaleStartDetails details) {_scaleStartGesture(details);},
            onInteractionUpdate: (details) =>
                _scaleUpdateGesture(details),
            onInteractionEnd: (details) =>
                _scaleEndGesture(details),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Stack(
                        children: [
                          Flexible(child: Image.file(imageFile,)),
                          for(Face face in faces)
                            Positioned(
                              top: face.boundingBox.top,
                              left: face.boundingBox.left,
                              child: Center(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: imageImage.width*_sigma*0.002,
                                      sigmaY: imageImage.height*_sigma*0.002,
                                    ),
                                    child: GestureDetector(
                                      onTapDown: (_) {
                                        showModalBottomSheet(context: context, builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    '초상권 침해',
                                                    style: TextStyle(
                                                        fontFamily: 'SCDream4',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 26)
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                    '타인의 얼굴을 고의 또는 실수로 찍어 유출하면\n초상권 침해로 손해배상을 청구 당할 수 있습니다',
                                                    style: TextStyle(
                                                        fontFamily: 'SCDream4',
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5)
                                                ),
                                                const SizedBox(height: 10),
                                                OutlinedButton(
                                                    onPressed: () => { launch("https://www.hani.co.kr/arti/culture/culture_general/786601.html") },

                                                    child: const Text(
                                                        "자세히 알아보기",
                                                        style: TextStyle(
                                                            color:  Colors.black45,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 1.5)
                                                    )
                                                ),
                                                const SizedBox(height: 30),
                                                const Text(
                                                    '개인 신상정보 노출',
                                                    style: TextStyle(
                                                        fontFamily: 'SCDream4',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 26)
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                    '자신의 얼굴이 들어간 사진을 노출하게 되면\n딥페이크, 사기 등의 범죄에 악용될 수 있습니다.',
                                                    style: TextStyle(
                                                        fontFamily: 'SCDream4',
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5)
                                                ),
                                                const SizedBox(height: 10),
                                                OutlinedButton(
                                                    onPressed: () => { launch("https://news.kbs.co.kr/news/view.do?ncd=5197994&ref=A") },

                                                    child: const Text(
                                                        "자세히 알아보기",
                                                        style: TextStyle(
                                                            color:  Colors.black45,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 1.5)
                                                    )
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    OutlinedButton(
                                                        style: OutlinedButton.styleFrom(
                                                            backgroundColor: Colors.red,
                                                            side: const BorderSide(color: Colors.red, width: 1)
                                                        ),
                                                        onPressed: () {
                                                          faces.remove(face);
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text(
                                                          '검열 해제',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: 'SCDream',
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        // alignment: Alignment.center,
                                        width: face.boundingBox.width,
                                        height: face.boundingBox.height,
                                        color: Colors.black.withOpacity(0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          for(TextLine textLine in textLines)
                            Positioned(
                              top: textLine.rect.top,
                              left: textLine.rect.left,
                              child: Center(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: imageImage.width*_sigma*0.002,
                                      sigmaY: imageImage.height*_sigma*0.002,
                                    ),
                                    child: GestureDetector(
                                      onTapDown: (_) {
                                        showModalBottomSheet(context: context, builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    '개인 고유 식별정보 노출',
                                                    style: TextStyle(
                                                        fontFamily: 'SCDream4',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 26)
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                    '자동차 번호판과 같은 개인정보는 내 다른 개인정보와\n결합하게 되면 사기 등의 범죄에 악용될 수 있습니다.',
                                                    style: TextStyle(
                                                        fontFamily: 'SCDream4',
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5)
                                                ),
                                                const SizedBox(height: 10),
                                                OutlinedButton(
                                                    onPressed: () => { launch("https://www.hani.co.kr/arti/economy/it/989178.html") },
                                                    child: const Text(
                                                        "자세히 알아보기",
                                                        style: TextStyle(
                                                            color:  Colors.black45,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 1.5)
                                                    )
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    OutlinedButton(
                                                        style: OutlinedButton.styleFrom(
                                                            backgroundColor: Colors.red,
                                                            side: const BorderSide(color: Colors.red, width: 1)
                                                        ),
                                                        onPressed: () {
                                                          textLines.remove(textLine);
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text(
                                                          '검열 해제',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: 'SCDream',
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        // alignment: Alignment.center,
                                        width: textLine.rect.width,
                                        height: textLine.rect.height,
                                        color: Colors.black.withOpacity(0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          for(Rect rect in added)
                            Positioned(
                              top: rect.top,
                              left: rect.left,
                              child: Center(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: imageImage.width*_sigma*0.002,
                                      sigmaY: imageImage.height*_sigma*0.002,
                                    ),
                                    child: Container(
                                      // alignment: Alignment.center,
                                      width: rect.width,
                                      height: rect.height,
                                      color: Colors.black.withOpacity(0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          CustomPaint(
                              painter: BlurDraw(context, faces: faces, imageImage: imageImage, textLines : textLines),
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 30),
        Flexible(
          flex: 3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Slider.adaptive(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  value: _sigma,
                  onChanged:(value) {
                    setState(() {
                      _sigma = value;
                    });
                  }),
            ),
          ),
        ),
      ],
    );
  }

  Column columnForSticker() {
    return Column(
      children: [
        Flexible(
          flex: 15,
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 5,
            onInteractionStart: (ScaleStartDetails details) {_scaleStartGesture(details);},
            onInteractionUpdate: (details) =>
                _scaleUpdateGesture(details),
            onInteractionEnd: (details) =>
                _scaleEndGesture(details),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Stack(
                      children: [
                        Flexible(child: Image.file(imageFile,)),
                        for(Face face in faces)
                          Positioned(
                            top: face.boundingBox.top,
                            left: face.boundingBox.left,
                            child: Center(
                              child: ClipRect(
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    showModalBottomSheet(context: context, builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                '초상권 침해',
                                                style: TextStyle(
                                                    fontFamily: 'SCDream4',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 26)
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                                '타인의 얼굴을 고의 또는 실수로 찍어 유출하면\n초상권 침해로 손해배상을 청구 당할 수 있습니다',
                                                style: TextStyle(
                                                    fontFamily: 'SCDream4',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5)
                                            ),
                                            const SizedBox(height: 10),
                                            OutlinedButton(
                                                onPressed: () => { launch("https://www.hani.co.kr/arti/culture/culture_general/786601.html") },

                                                child: const Text(
                                                    "자세히 알아보기",
                                                    style: TextStyle(
                                                        color:  Colors.black45,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5)
                                                )
                                            ),
                                            const SizedBox(height: 30),
                                            const Text(
                                                '개인 신상정보 노출',
                                                style: TextStyle(
                                                    fontFamily: 'SCDream4',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 26)
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                                '자신의 얼굴이 들어간 사진을 노출하게 되면\n딥페이크, 사기 등의 범죄에 악용될 수 있습니다.',
                                                style: TextStyle(
                                                    fontFamily: 'SCDream4',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5)
                                            ),
                                            const SizedBox(height: 10),
                                            OutlinedButton(
                                                onPressed: () => { launch("https://news.kbs.co.kr/news/view.do?ncd=5197994&ref=A") },

                                                child: const Text(
                                                    "자세히 알아보기",
                                                    style: TextStyle(
                                                        color:  Colors.black45,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5)
                                                )
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                OutlinedButton(
                                                    style: OutlinedButton.styleFrom(
                                                        backgroundColor: Colors.red,
                                                        side: const BorderSide(color: Colors.red, width: 1)
                                                    ),
                                                    onPressed: () {
                                                      faces.remove(face);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      '검열 해제',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'SCDream',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    // alignment: Alignment.center,
                                    width: face.boundingBox.width,
                                    height: face.boundingBox.height,
                                    color: Colors.black.withOpacity(0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        for(TextLine textLine in textLines)
                          Positioned(
                            top: textLine.rect.top,
                            left: textLine.rect.left,
                            child: Center(
                              child: ClipRect(
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    showModalBottomSheet(context: context, builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                '개인 고유 식별정보 노출',
                                                style: TextStyle(
                                                    fontFamily: 'SCDream4',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 26)
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                                '자동차 번호판과 같은 개인정보는 내 다른 개인정보와\n결합하게 되면 사기 등의 범죄에 악용될 수 있습니다.',
                                                style: TextStyle(
                                                    fontFamily: 'SCDream4',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5)
                                            ),
                                            const SizedBox(height: 10),
                                            OutlinedButton(
                                                onPressed: () => { launch("https://www.hani.co.kr/arti/economy/it/989178.html") },
                                                child: const Text(
                                                    "자세히 알아보기",
                                                    style: TextStyle(
                                                        color:  Colors.black45,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5)
                                                )
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                OutlinedButton(
                                                    style: OutlinedButton.styleFrom(
                                                        backgroundColor: Colors.red,
                                                        side: const BorderSide(color: Colors.red, width: 1)
                                                    ),
                                                    onPressed: () {
                                                      textLines.remove(textLine);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      '검열 해제',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'SCDream',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    // alignment: Alignment.center,
                                    width: textLine.rect.width,
                                    height: textLine.rect.height,
                                    color: Colors.black.withOpacity(0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        CustomPaint(
                            painter: StickerDraw(context, faces, textLines, imageImage, stickerImage,added),
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(height: 30),
        Flexible(
          flex: 3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  mainAxisSpacing: 5,
                  children: [
                    for (int i = 0; i < stickers.length; i++)
                      StickerOption(
                        stickers[i]['name'] as String,
                        img: stickers[i]['img'] as String,
                        onTap: () async {
                          checkOption(i + 1);
                          _stickerImage = await getImageFileFromAssets('sticker'+_stickerId.toString()+'.png');
                          convertImageType();
                        },
                        selected: i + 1 == _stickerId,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NewGradientAppBar(
        elevation: 0,
        gradient: const LinearGradient(
            colors: [Color(0xff647dee), Color(0xff7f53ac)]
        ),
        title: const Text(
          '사진 검열',
          style: TextStyle(
              fontFamily: 'SCDream4'
          ),),
        actions: [
          IconButton(
              onPressed: () {
                added.removeLast();
              },
              icon: const Icon(Icons.reply))
          // TextButton(
          //     onPressed: () {
          //       for(TextBlock block in textBlocks) {
          //         print('textBlock: ${block.text}');
          //         for (TextLine line in block.lines) {
          //           print('line: ${line.text}');
          //         }
          //       }
          //     },
          //     child: const Text('읽기', style: TextStyle(color: Colors.white),)),
          // Visibility(
          //   visible: stickerVisibility,
          //   child: TextButton(onPressed: convertImageType,
          //       child: const Text('검열', style: TextStyle(color: Colors.white),)),
          // )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Center(
                child: ToggleSwitch(
                  minWidth: MediaQuery.of(context).size.width,
                  cornerRadius: 20.0,
                  activeBgColors: const [[Color(0xff647dee)], [Color(0xff647dee)]],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.transparent,
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: selectedIndex,
                  totalSwitches: 2,
                  labels: const ['블러', '스티커'],
                  radiusStyle: true,
                  onToggle: (index) {
                    bringSticker();
                    convertImageType();
                    setState(() {
                      selectedIndex = index;
                    });
                    if (selectedIndex == 0) {
                      _blurShow();
                      _stickerHide();
                    }
                    else {
                      _blurHide();
                      _stickerShow();
                    }
                    selectedIndex = index;
                  },
                ),
              ),
            ),
            if (blurVisibility != true) Flexible(flex: 18, child: columnForSticker()) else Flexible(flex: 18, child: columnForBlur())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: 사진 저장 및 공유 (헌재)
          },
        tooltip: 'Select',
        child: const Icon(Icons.image),
      ),
    );
  }
}

class BlurDraw extends CustomPainter {
  List<Face> faces;
  List<TextLine> textLines;
  ui.Image imageImage;
  final BuildContext context;

  BlurDraw(this.context,{@required this.faces, @required this.imageImage, @required this.textLines});

  @override

  void paint(Canvas canvas, Size size) {

    for (Face face in faces) {

      canvas.drawCircle(
        Offset(face.boundingBox.left, face.boundingBox.top),
        face.boundingBox.width/15,
        Paint()
          ..color = Colors.red.withOpacity(0.8)
          ..strokeWidth = face.boundingBox.width/10
          ..style = PaintingStyle.fill,);


      TextPainter paintSpanId = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: face.boundingBox.width.toDouble()/9,
            fontWeight: FontWeight.w400,
          ),
          text: "!",
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      paintSpanId.layout();
      paintSpanId.paint(canvas, Offset(face.boundingBox.left - face.boundingBox.width/60, face.boundingBox.top - face.boundingBox.width/16));
    }

    for (TextLine textLine in textLines) {

      canvas.drawCircle(
        Offset(textLine.rect.left, textLine.rect.top),
        textLine.rect.width/15,
        Paint()
          ..color = Colors.red.withOpacity(0.8)
          ..strokeWidth = textLine.rect.width/10
          ..style = PaintingStyle.fill,);


      TextPainter paintSpanId = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: textLine.rect.width.toDouble()/9,
            fontWeight: FontWeight.w400,
          ),
          text: "!",
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      paintSpanId.layout();
      paintSpanId.paint(canvas, Offset(textLine.rect.left - textLine.rect.width/60, textLine.rect.top - textLine.rect.width/16));

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class StickerDraw extends CustomPainter {
  List<Face> faces;
  List<TextLine> textLines;
  List<Rect> added;
  ui.Image image;
  final BuildContext context;
  ui.Image coverImage;

  StickerDraw(this.context, this.faces, this.textLines, this.image, this.coverImage, this.added);

  @override

  void paint(Canvas canvas, Size size) {

    for (Face face in faces) {

      canvas.drawImageRect(
          coverImage,
          Offset.zero & Size(coverImage.width.toDouble(), coverImage.height.toDouble()),
          Offset(face.boundingBox.left, face.boundingBox.top) & Size(face.boundingBox.width, face.boundingBox.height),
          Paint());

      canvas.drawCircle(
        Offset(face.boundingBox.left, face.boundingBox.top),
        face.boundingBox.width/15,
        Paint()
          ..color = Colors.red.withOpacity(0.8)
          ..strokeWidth = face.boundingBox.width/10
          ..style = PaintingStyle.fill,);


      TextPainter paintSpanId = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: face.boundingBox.width.toDouble()/9,
            fontWeight: FontWeight.w400,
          ),
          text: "!",
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      paintSpanId.layout();
      paintSpanId.paint(canvas, Offset(face.boundingBox.left - face.boundingBox.width/60, face.boundingBox.top - face.boundingBox.width/16));

    }

    for (TextLine textLine in textLines) {

      canvas.drawImageRect(
          coverImage,
          Offset.zero & Size(coverImage.width.toDouble(), coverImage.height.toDouble()),
          Offset(textLine.rect.left, textLine.rect.top) & Size(textLine.rect.width, textLine.rect.height),
          Paint());

      canvas.drawCircle(
        Offset(textLine.rect.left, textLine.rect.top),
        textLine.rect.width/15,
        Paint()
          ..color = Colors.red.withOpacity(0.8)
          ..strokeWidth = textLine.rect.width/10
          ..style = PaintingStyle.fill,);


      TextPainter paintSpanId = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: textLine.rect.width.toDouble()/9,
            fontWeight: FontWeight.w400,
          ),
          text: "!",
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      paintSpanId.layout();
      paintSpanId.paint(canvas, Offset(textLine.rect.left - textLine.rect.width/60, textLine.rect.top - textLine.rect.width/16));

    }

    for (Rect rect in added) {
      canvas.drawImageRect(
          coverImage,
          Offset.zero & Size(coverImage.width.toDouble(), coverImage.height.toDouble()),
          Offset(rect.left, rect.top) & Size(rect.width, rect.height),
          Paint());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class StickerOption extends StatelessWidget {

  const StickerOption(
      this.title, {
        Key key,
        this.img,
        this.onTap,
        this.selected,
      }) : super(key: key);

  final String title;
  final String img;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      fit: BoxFit.contain,
      image: AssetImage(img),
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: selected ?? false ? const Color(0xff647dee) : Colors.transparent,
                      width: selected ?? false ? 10 : 0,
                    )
                )
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Flexible(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected ?? false ? const Color(0xff7f53ac) : Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Staatliches-Regular'
                    ),
                  ),
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }
}

