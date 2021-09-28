import 'package:data_tective/detect/detection_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

ImagePicker picker = ImagePicker();

enum ImageSourceType { gallery, camera }

class ImageFromGalleryEx extends StatefulWidget {
  final ImageSourceType sourceType;
  final int _stickerId;
  const ImageFromGalleryEx(this.sourceType, this._stickerId, {Key key}) : super(key: key);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(sourceType, _stickerId);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {

  ImagePicker imagePicker = ImagePicker();

  File imageFile;
  ImageSourceType sourceType;
  final int _stickerId;

  ImageFromGalleryExState(this.sourceType, this._stickerId);

  @override
  void initState() {
    super.initState();
    openImagePicker();
  }

  void openImagePicker() async {
    XFile image = await imagePicker.pickImage(
        source:
        sourceType.index == ImageSourceType.camera.index
        ? ImageSource.camera
        : ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      imageFile = File(image.path);
    });
  }

  void send(BuildContext context, File file) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetectionScreen(file, _stickerId)));
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         send(context, _image);
        //         },
        //       icon: const Icon(Icons.arrow_forward_ios))
        // ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Container(
            child: imageFile != null
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(child: Image.file(imageFile, fit: BoxFit.contain,)),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xff7f53ac);
                      }
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
                OutlinedButton(
                  onPressed: openImagePicker,
                  child: const Text(
                      '이미지를 다시 선택할래요',
                    style: TextStyle(
                      fontFamily: 'SCDream4'
                    ),),
                )
              ],
            )
                :Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                    Icons.image_not_supported_outlined,
                    size: 150),
                const SizedBox(height: 50.0),
                const Text(
                  '아직 아무 사진을 고르지 않으셨습니다',
                  style: TextStyle(
                      fontFamily: 'SCDream4',
                      fontSize: 12,
                      color: Colors.grey
                  ),),
                const SizedBox(height: 20,),
                OutlinedButton(
                  onPressed: openImagePicker,
                  child: Text(
                    sourceType.index == ImageSourceType.camera.index
                      ?'카메라 열기'
                    :'갤러리 열기',
                    style: const TextStyle(
                      fontFamily: 'SCDream4',
                      fontSize: 14
                    ),),
                )
              ],
            )
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // child: SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   child: _image != null
            //       ? Expanded(
            //     child: Image.file(
            //       _image,
            //       width: 200.0,
            //       height: 200.0,
            //       fit: BoxFit.contain,
            //     ),
            //   )
            //       : Icon(sourceType.index == ImageSourceType.camera.index
            //       ? Icons.camera_alt
            //       : Icons.image,
            //     size: 150,
            //     color: Colors.grey[800],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}