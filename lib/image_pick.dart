import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart'
    show ImageSource;
import 'dart:io';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'detect/detection_screen.dart';

ImagePicker picker = ImagePicker();


class ImageFromGalleryEx extends StatefulWidget {
  final ImageSource sourceType;
  const ImageFromGalleryEx(this.sourceType, {Key key}) : super(key: key);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(sourceType);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {

  ImagePicker imagePicker = ImagePicker();

  File imageFile;
  ImageSource sourceType;

  ImageFromGalleryExState(this.sourceType);

  @override
  void initState() {
    super.initState();
    openImagePicker();
  }

  void openImagePicker() async {
    XFile image = await imagePicker.pickImage(
        source: sourceType,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      imageFile = File(image.path);
    });
  }

  void send(BuildContext context, File file) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetectionScreen(file)));
  }

  Column columnForImageReady(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(child: Image.file(imageFile, fit: BoxFit.contain,)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                return const Color(0xff647dee);
              }),),
            onPressed: () {
              send(context, imageFile);
            },
            child: const Text(
              '이 이미지를 검열할래요',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SCDream4'
              ),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: OutlinedButton(
            onPressed: openImagePicker,
            child: const Text(
              '이미지를 다시 선택할래요',
              style: TextStyle(
                  fontFamily: 'SCDream4'
              ),),
          ),
        )
      ],
    );
  }

  Column columnForNoImage(){
    String _outLinedButtonText;
    switch (sourceType) {
      case ImageSource.camera:
        _outLinedButtonText = '카메라 열기';
        break;
      default: // case ImageSource.gallery
        _outLinedButtonText = '갤러리 열기';
        break;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.image_not_supported_outlined, size: 150),
        const SizedBox(height: 50.0),
        const Text('아직 아무 사진을 고르지 않으셨습니다',
          style: TextStyle(
              fontFamily: 'SCDream4', fontSize: 12, color: Colors.grey
          ),),
        const SizedBox(height: 20,),
        OutlinedButton(
          onPressed: openImagePicker,
          child: Text(_outLinedButtonText,
            style: const TextStyle(
                fontFamily: 'SCDream4', fontSize: 14
            ),),
        )
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
          '사진 불러오기',
          style: TextStyle(
              fontFamily: 'SCDream4'
          ),),
      ),
      body: Center(child: imageFile != null ? columnForImageReady() : columnForNoImage()),
    );
  }
}