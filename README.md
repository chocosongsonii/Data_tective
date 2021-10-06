# Data_tective

#### 2021 삼성 주니어 SW 창작대회
Da-tective팀이 만든 내 손 안의 작은 AI 탐정

## 프로젝트 계획 이유

휴대폰이 보급되고 SNS 사용이 빈번해지는 요즘 시대에 SNS 이용을 하는 사람들이 많아지고 있습니다.

이 앱은 SNS 이용에 있어서 경각심이 별로 없는 사람들을 위해 AI탐정이 직접 체크해주고 가려주는 앱입니다.

SNS는 사람들이 자신을 표현할 수 있는 창구이기도 하지만 한편으로는 나의 중요한 개인정보들이 빠져나갈 수 있는 통로이기도 합니다.

실수로 나 자신 혹은 타인의 개인정보를 SNS에 업로드해버리는 당혹스러운 상황에서 사용자들을 지켜주기 위해 이 앱을 계획하게 되었습니다.

## 앱 기능

### 1. 갤러리 또는 카메라를 사용해 검열할 사진 불러오기

``` Dart
XFile image = await imagePicker.pickImage(
            source: sourceType,
            imageQuality: 50,
            preferredCameraDevice: CameraDevice.front);
```

Image Picker을 사용하여 갤러리 또는 카메라에서 사진을 불러옵니다.

### 2. AI 검열

``` Dart
final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
    ));
    final TextDetector textDetector = GoogleMlKit.vision.textDetector();
```

GoogleMlKit을 사용하여 사진 속 모든 얼굴과 텍스트를 인식합니다.

``` Dart
for (var element in textLines) {
        textStr = element.text;
        num = textStr.replaceAll(RegExp(r'[^0-9]'), '');
        if (num.length < 6) {
          toRemoveTextLine.add(element);
        }
      }
      textLines.removeWhere((element) => toRemoveTextLine.contains(element));
```

인식한 텍스트 속에 글자를 모두 삭제합니다. 그렇게 숫자만 남은 텍스트 길이가 6보다 작으면 해당 텍스트는 검열에서 제외됩니다.

``` Dart
if (faces.length <= 1) {
        faces.clear();
      }

      for (Face face in faces) {
        widthSum += face.boundingBox.width;
        widthAverage = widthSum/faces.length;
      }
      for (Face face in faces) {
        if (face.boundingBox.width > widthAverage*1.2) {
          toRemoveFace.add(face);
        }
      }
      faces.removeWhere((face) => toRemoveFace.contains(face));
```

사진 속 인식된 얼굴이 하나일 경우 그 얼굴은 사용자일 확률이 높기 때문에 검열 대상에서 제외됩니다.

또한 모든 얼굴들의 가로 길이를 평균을 내어 만일 얼굴의 가로 길이가 평균보다 1.2배 크면 그 얼굴은 사용자가 고의로 찍은 얼굴일 확률이 높기 때문에 검열 대상에서 제외됩니다.

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
