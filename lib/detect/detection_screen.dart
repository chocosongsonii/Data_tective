import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:touchable/touchable.dart';
import 'blur.dart';
import 'sticker_cover.dart';

class DetectionScreen extends StatefulWidget {
  final File imageFile;
  final int _stickerId;
  const DetectionScreen(this.imageFile, this._stickerId);

  @override
  _DetectionScreenState createState() => _DetectionScreenState(imageFile, _stickerId);
}

class _DetectionScreenState extends State<DetectionScreen> {
  // ui.Image imageSelected;
  // List<Face> faces;

  File imageFile;
  final int _stickerId;
  _DetectionScreenState(this.imageFile, this._stickerId);

  ui.Image imageImage;
  List<Face> faces = [];
  List<TextBlock> textBlocks = [];

  @override
  void initState() {
    super.initState();
    getImage();
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
    });
  }

  void _sendBlurFace(context, var faces, var images, var imageSelected) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Blur(faces, images, imageSelected)),
    );
  }

  void _sendCoverFace(context, var faces, var images, var imageSelected, var _stickerId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageCover(faces, images, imageSelected, _stickerId)),
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
              fontFamily: 'Staatliches-Regular'
          ),),
        actions: [
          TextButton(
              onPressed: () {
                _stickerId == 1
                    ?_sendBlurFace(context, faces, imageFile, imageImage)
                    :_sendCoverFace(context,faces,imageFile,imageImage, _stickerId);
              },
              child: const Text('완료', style: TextStyle(color: Colors.white),)),
          TextButton(
              onPressed: () {
                for(TextBlock block in textBlocks) {
                  for (TextLine line in block.lines) {
                    print('text: ${line.text}');
                  }
                }
              },
              child: const Text('읽기', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: FittedBox(
            fit: BoxFit.contain,
             child: SizedBox(
               height: imageImage != null
                 ?imageImage.height.toDouble()
               :300,
               width: imageImage != null
                 ?imageImage.width.toDouble()
               :300,
               // child: Image.file(image),
               child: CanvasTouchDetector(
                 builder: (context) => CustomPaint(
                   painter: FaceDraw(context, faces: faces, imageImage: imageImage, textBlocks: textBlocks),
                 ),
               ),
             ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          faces.clear();
          },
        tooltip: 'Select',
        child: const Icon(Icons.image),
      ),
    );
  }
}

class FaceDraw extends CustomPainter {
  List<Face> faces;
  List<TextBlock> textBlocks;
  ui.Image imageImage;
  final BuildContext context;

  FaceDraw(this.context,{@required this.faces, @required this.imageImage, @required this.textBlocks});

  @override

  void paint(Canvas canvas, Size size) {
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    touchyCanvas.drawImage(
        imageImage,
        Offset.zero,
        Paint()
    );

    for (TextBlock textBlock in textBlocks) {

      touchyCanvas.drawRect(Rect.fromLTRB(textBlock.rect.left, textBlock.rect.top, textBlock.rect.right, textBlock.rect.bottom), Paint()
        ..color = Colors.transparent
          , onTapDown: (_) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('개인고유식별 번호 노출 위험'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          const Text('이 검열을 해제하시겠습니까?'),
                          const Text('다시 검열하기 위해서는 이미지 편집을 새로 시작하셔야 합니다'),
                          TextButton(
                            child: Row(
                              children: const [
                                Text('자세히 보기',
                                    style: TextStyle(color: Colors.red)),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },)
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('취소'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },),
                      TextButton(
                        child: const Text('해제',
                            style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          textBlocks.remove(textBlock);
                          Navigator.of(context).pop();
                        },)
                    ],
                  );
                }
            );
          });

      touchyCanvas.drawRect(
        Rect.fromLTRB(textBlock.rect.left, textBlock.rect.top, textBlock.rect.right, textBlock.rect.bottom),
        // face.boundingBox,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.greenAccent
          ..strokeWidth = 4,
      );

      touchyCanvas.drawLine(
        Offset(textBlock.rect.left + 5, textBlock.rect.top - 12),
        Offset(textBlock.rect.left + 160, textBlock.rect.top - 12),
        Paint()
          ..color = Colors.red.withOpacity(0.8)
          ..strokeWidth = 18
          ..style = PaintingStyle.fill,);


      TextPainter paintSpanId = TextPainter(
        text: const TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          text: "자동차 번호판 노출 위험!",
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      paintSpanId.layout();
      paintSpanId.paint(canvas, Offset(textBlock.rect.left + 10, textBlock.rect.top - 20));

    }

    for (Face face in faces) {

      // var da = Offset(face.boundingBox.left, face.boundingBox.top);
      // var db = Offset(face.boundingBox.right, face.boundingBox.top);
      // var dc = Offset(face.boundingBox.left, face.boundingBox.bottom);
      // var dd = Offset(face.boundingBox.right, face.boundingBox.bottom);

      // print("ID: ${face.trackingId}");
      // print(da);print(db);print(dc);print(dd);

      var blueRect = Rect.fromLTWH(face.boundingBox.left, face.boundingBox.top, face.boundingBox.width, face.boundingBox.height);

      touchyCanvas.drawRect(blueRect, Paint()
        ..color = Colors.transparent
          , onTapDown: (_) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('초상권 침해'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      const Text('이 검열을 해제하시겠습니까?'),
                      const Text('다시 검열하기 위해서는 이미지 편집을 새로 시작하셔야 합니다'),
                      TextButton(
                        child: Row(
                          children: const [
                            Text('자세히 보기',
                                style: TextStyle(color: Colors.red)),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                        onPressed: () {
                          faces.remove(face);
                          Navigator.of(context).pop();
                        },)
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },),
                  TextButton(
                    child: const Text('해제',
                    style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      print('You clicked' "ID: ${face.trackingId}");
                      faces.remove(face);
                      Navigator.of(context).pop();
                    },)
                ],
              );
            }
        );
      });

      touchyCanvas.drawRect(
          Rect.fromLTWH(face.boundingBox.left, face.boundingBox.top, face.boundingBox.width, face.boundingBox.height),
        // face.boundingBox,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.greenAccent
          // ..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10)
          ..strokeWidth = 4,
      );

      touchyCanvas.drawLine(
                Offset(face.boundingBox.left + 5, face.boundingBox.top - 12),
                Offset(face.boundingBox.left + 120, face.boundingBox.top - 12),
                Paint()
                  ..color = Colors.red.withOpacity(0.8)
                  ..strokeWidth = 18
                  ..style = PaintingStyle.fill,);


      TextPainter paintSpanId = TextPainter(
        text: const TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          text: "초상권 침해 위험!",
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      paintSpanId.layout();
      paintSpanId.paint(canvas, Offset(face.boundingBox.left + 10, face.boundingBox.top - 20));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
