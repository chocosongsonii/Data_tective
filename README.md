# Data-tective

#### 2021 삼성 주니어 SW 창작대회
Da-tective팀이 만든 내 손 안의 작은 AI 탐정

## 설치 방법

**Step 1:** 레파지토리를 다운로드 하거나 클론을 합니다

```
git clone https://github.com/chocosongsonii/Data_tective
```

**Step 2:** 프로젝트에 필요한 패키지를 다운로드합니다

```
flutter pub get
```

**Step 3:** 플러터 앱을 실행합니다.

```
flutter run
```

## 프로젝트 계획 이유

>휴대폰이 보급되고 SNS 사용이 빈번해지는 요즘 시대에 SNS 이용을 하는 사람들이 많아지고 있습니다.
이 앱은 SNS 이용에 있어서 경각심이 별로 없는 사람들을 위해 AI탐정이 직접 체크해주고 가려주는 앱입니다.
SNS는 사람들이 자신을 표현할 수 있는 창구이기도 하지만 한편으로는 나의 중요한 개인정보들이 빠져나갈 수 있는 통로이기도 합니다.
실수로 나 자신 혹은 타인의 개인정보를 SNS에 업로드해버리는 당혹스러운 상황에서 사용자들을 지켜주기 위해 이 앱을 계획하게 되었습니다.


## 앱 기능

### 1. 갤러리 또는 카메라를 사용해 검열할 사진 불러오기

Image Picker를 사용하여 갤러리 또는 카메라에서 사진을 불러옵니다.

``` Dart
XFile image = await imagePicker.pickImage(
            source: sourceType,
            imageQuality: 50,
            preferredCameraDevice: CameraDevice.front);
```

------------

### 2. AI 검열

GoogleMlKit을 사용하여 사진 속 모든 얼굴과 텍스트를 인식합니다.

``` Dart
final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
));
final TextDetector textDetector = GoogleMlKit.vision.textDetector();
```

인식한 텍스트 속에 글자를 모두 삭제합니다.

그렇게 숫자만 남은 텍스트 길이가 6보다 작으면 해당 텍스트는 검열에서 제외됩니다.

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
사진 속 인식된 얼굴이 하나일 경우 그 얼굴은 사용자일 확률이 높기 때문에 검열 대상에서 제외됩니다.

또한 모든 얼굴들의 가로 길이를 평균을 내어 만일 얼굴의 가로 길이가 평균의 1.2배보다 크면 그 얼굴은 사용자가 고의로 찍은 얼굴일 확률이 높기 때문에 검열 대상에서 제외됩니다.

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

------------

### 3. 검열 방법 설정

상단의 Toggle Switch를 이용하여 이미지를 검열할 방식을 고를 수 있습니다.

블러를 선택하면 슬라이더를 이용하여 블러강도를 조절할 수 있습니다.

(https://user-images.githubusercontent.com/88924667/136510009-1de20698-7200-4b4c-acf5-5c4c50f3e779.gif)

스티커를 선택하면 여러 스티커들 중 마음에 드는 스티커를 사용하여 검열을 할 수 있습니다.

(스티커 사용하는 git올리기)

------------

### 4. 관련 정보 제공

AI를 통해 검열된 얼굴 또는 텍스트는 좌측 상단에 빨간색 '!' 이 뜹니다.

이때 '!'이 아닌 검열된 부분을 누르면 하단에서 페이지가 올라옵니다.

(사진 추가)

이 하단 페이지에서는 검열된 개인정보에 대한 설명과 관련 링크로의 하이퍼링크를 제공합니다.

또한 우측 하단에 있는 검열 해제 버튼을 눌러 검열을 해제할 수 있습니다.

------------

### 5. 추가 검열

사진 내에 AI가 검열하지 못한 부분이 있거나 사용자가 임의로 더 추가하고 싶은 부분이 있다면 직접 드래그하여 추가할 수 있습니다.

검열을 추가할 때는 좌측 상단에서 우측 하단 방향으로 드래그하여 추가할 수 있습니다.

(이 방향이 지켜지지 않을 경우 검열이 추가되지 않습니다.)

추가한 검열이 마음에 들지 않는다면 화면의 우측 상단에 위치한 뒤로가기 버튼을 눌러 취소할 수 있습니다.
