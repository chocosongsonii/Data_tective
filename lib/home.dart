import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart'
    show ImageSource;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'image_pick.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 1;

  void sendToImagePick(BuildContext context, ImageSource sourceType) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(sourceType)));
  }

  @override
  void initState() {
    super.initState();
    // _loadId();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 투명색
    ));

    List _widgetOptions = [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ExpansionTile(
                title: const Text(
                  '앱에 사용된 폰트',
                  style: TextStyle(
                    fontFamily: 'SCDream6',
                    color: Colors.black,
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '이 앱에는 에스코어가 제공한 에스코어 드림 폰트와 적용되어 있습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '이 앱에는 Google Fonts가 제공한 Staatliches-Regular 폰트가 적용되어 있습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '앱에 사용된 오픈소스',
                  style: TextStyle(
                    fontFamily: 'SCDream6',
                    color: Colors.black,
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Theme(
                              data: ThemeData.dark(),
                              child: LicensePage(
                                applicationIcon: Image.asset('assets/splash.png'),
                                applicationName: 'Data-tective',
                              ),
                            )));
                          },
                          child: const Text('라이선스 보러 가기 >',
                            style: TextStyle(
                              fontFamily: 'SCDream6',
                              color: Colors.black,
                            ),)
                        )
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '앱에 사용된 예제들',
                  style: TextStyle(
                    fontFamily: 'SCDream6',
                    color: Colors.black,
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpansionTile(
                          title: const Text(
                            'Flutter Face Detection',
                            style: TextStyle(
                              fontFamily: 'SCDream6',
                              color: Colors.black,
                            ),),
                          subtitle: const Text('TiagoDanin', style: TextStyle(fontFamily: 'SCDream6', color: Colors.black),),
                          controlAffinity: ListTileControlAffinity.leading,
                          initiallyExpanded: false,
                          backgroundColor: Colors.transparent,
                          iconColor: const Color(0xff647dee),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Text('MIT License\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('Copyright (c) 2021 Tiago Danin\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('Permission is hereby granted, free of charge, to any person obtaining a copy\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('of this software and associated documentation files (the "Software"), to deal\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('in the Software without restriction, including without limitation the rights\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('copies of the Software, and to permit persons to whom the Software is\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('furnished to do so, subject to the following conditions:\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('The above copyright notice and this permission notice shall be included in all\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('copies or substantial portions of the Software.\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('SOFTWARE.',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                              ],
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: const Text(
                            'Flutter Plugin example <Share>',
                            style: TextStyle(
                              fontFamily: 'SCDream6',
                              color: Colors.black,
                            ),),
                          subtitle: const Text('Flutter', style: TextStyle(fontFamily: 'SCDream6', color: Colors.black),),
                          controlAffinity: ListTileControlAffinity.leading,
                          initiallyExpanded: false,
                          backgroundColor: Colors.transparent,
                          iconColor: const Color(0xff647dee),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Text('Copyright 2013 The Flutter Authors. All rights reserved.\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('Redistribution and use in source and binary forms, with or without modification,\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('are permitted provided that the following conditions are met:\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('    * Redistributions of source code must retain the above copyright\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('      notice, this list of conditions and the following disclaimer.\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('    * Redistributions in binary form must reproduce the above\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('      copyright notice, this list of conditions and the following\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('      with the distribution.\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('    * Neither the name of Google Inc. nor the names of its\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('      contributors may be used to endorse or promote products derived\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('      from this software without specific prior written permission.\n\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\n',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                                Text('SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                              ],
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: const Text(
                            'Selectable GridView',
                            style: TextStyle(
                              fontFamily: 'SCDream6',
                              color: Colors.black,
                            ),),
                          subtitle: const Text('@ramgendeploy', style: TextStyle(fontFamily: 'SCDream6', color: Colors.black),),
                          controlAffinity: ListTileControlAffinity.leading,
                          initiallyExpanded: false,
                          backgroundColor: Colors.transparent,
                          iconColor: const Color(0xff647dee),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Text('https://ramagg.com/flutter-selectable-grid/',
                                  style: TextStyle(
                                      fontFamily: 'SCDream4',
                                      fontSize: 7
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.image,
                size: 50,
                color: Color(0xff5565db),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Column(
                  children: const [
                    Text(
                        '검열할 이미지를',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'SCDream6',
                      ),),
                    Text(
                      '선택해주세요',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'SCDream6',
                      ),),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    sendToImagePick(context, ImageSource.gallery);
                  },
                  child: const Text(
                    '갤러리 열기',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'SCDream4',
                      color: Color(0xff647dee)
                    )
                  )
              ),
              const SizedBox(height: 10.0),
              OutlinedButton(
                  onPressed: () {
                    sendToImagePick(context, ImageSource.camera);
                  },
                  child: const Text(
                      '카메라 열기',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'SCDream4',
                          color: Color(0xff647dee)
                      )
                  )
              ),
            ],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpansionTile(
                title: const Text(
                  '이 앱은 무엇을 위한 앱인가요?',
                  style: TextStyle(
                    fontFamily: 'SCDream6',
                    color: Colors.black,
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '이 앱은 SNS 이용에 있어서 경각심이 별로 없는 사람들을 위해 AI탐정이 직접 체크해주고 가려주는 앱입니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          'SNS는 사람들이 자신을 표현할 수 있는 창구이기도 하지만 한편으로는 나의 중요한 개인정보들이 빠져나갈 수 있는 통로이기도 합니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '실수로 나 자신 혹은 타인의 개인정보를 SNS에 업로드해버리는 당혹스러운 상황에서 사용자들을 지켜주고 사진 속에 어떠한 위험이 있는지 사용자들에게 경각심을 줄 수 있는 앱입니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '이 앱의 사용방법',
                  style: TextStyle(
                      fontFamily: 'SCDream6',
                      color: Colors.black
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '갤러리에서 이미지를 가져오거나 카메라로 사진을 찍어 검열을 시작할 수 있습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '사진 속에 얼굴이 하나만 있을 경우 그 얼굴은 사용자의 얼굴일 확률이 높아 검열을 하지 않습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '또한, 검열된 얼굴들 중 상대적으로 큰 얼굴들은 사용자일 확률이 높기 때문에 검열에서 제외됩니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '검열 화면에서는 블러, 또는 스티커를 사용하여 검열된 부분을 가릴 수 있습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '블러로 가릴 경우 하단 슬라이더에서 블러 강도를 조절할 수 있고, 스티커로 가릴 경우 직접 여러 스티커들 중 마음에 드는 것을 골라 검열하는 것이 가능합니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "AI가 인식한 검열되어야할 부분에는 '!' 이라고 쓰여진 빨간 동그라미가 좌측 상단에 있습니다.",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "이 검열 부분을 누르면 관련 개인정보에 대한 사용자들의 경각심을 높일 수 있는 관련 링크와 검열을 해제할 수 있는 검열 해제 버튼이 있습니다.",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "(※빨간 동그라미가 아닌 '검열된 부분'을 누르셔야지 인식이 됩니다)",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15,
                              color: Colors.red
                          ),),
                        Text(
                          '(※여기서 해제한 검열은 되돌릴 수 없으며 되돌리려면 검열을 처음부터 다시 시작해야합니다.)\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15,
                              color: Colors.red
                          ),),
                        Text(
                          '이미지 내에서 추가로 검열하고 싶은 부분이 있으면 드래그하여 추가할 수 있습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '드래그하여 추가할 때는 추가로 검열하고 싶은 부분의 좌측 상단에서 우측 하단까지 드래그 해주시면 됩니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '(※이 방향이 지켜지지 않을 시 검열이 추가 되지 않습니다)',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15,
                              color: Colors.red
                          ),),
                        Text(
                          '추가한 검열이 마음에 들지 않는다면 화면의 우측 상단에 위치한 뒤로 가기 버튼을 눌러 취소할 수 있습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '검열을 끝마친 후에는 우측 하단에 있는 버튼을 눌러 이미지를 기기에 저장하거나 다른 SNS에 공유할 수 있습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '이 앱으로 미래가 어떻게 달라질 수 있을까요?',
                  style: TextStyle(
                      fontFamily: 'SCDream6',
                      color: Colors.black
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '인공지능을 활용하여 더욱 용이하게 자신이 발견하지 못해 발생하는 개인정보 유출을 방지하여 자신의 개인정보를 지키며 더욱 다양한 SNS 활동을 할 수 있을 것 입니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '또한 관련 정보를 제공함으로써 사용자들에게 개인정보 유출 문제의 중요성을 깨닫게 하여 SNS에서의 개인정보 유출에 대한 경각심을 가지게 할 수 있습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '따라서 SNS 사용시의 개인정보 유출이 줄어들어 보이스피싱, 도용, 사기 등의 관련 피해가 줄어들 것입니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '이 앱의 발전 가능성',
                  style: TextStyle(
                      fontFamily: 'SCDream6',
                      color: Colors.black
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '처음 앱을 구상하였을 때는 앱보다는 오픈 소스 형태로 만들어 사진을 사용하는 여러 플랫폼들에서 사용을 해주었으면 좋겠다고 생각하였습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '만일 이 앱과 같은 기능을 가진 오픈 소스가 있다면 영상 편집 앱, SNS 앱 등에서 활용되어 사용자들이 한층 더 쉽고 빠르게 개인정보를 검열할 수 있게 될 것입니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '또한 만일 이 앱이 동영상 검열으로까지 확장한다면 온라인상에서 사용자들이 개인정보 노출에 대한 걱정 없이 소통의 자유를 무한히 누리는 사회가 될 수 있을것이라 생각합니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '이 앱은 누가 만들었나요?',
                  style: TextStyle(
                      fontFamily: 'SCDream6',
                      color: Colors.black
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '이 앱은 보평고등학교 고등학교 2학년 학생 윤예영, 이지현, 정헌재가 다 같이 힘을 합쳐 만들었습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '예영이는 자신을 발전시킬 수 있는 대회에 대해 관심이 많았고 인터넷을 찾아보던 와중에 삼성 주니어 SW 창작대회를 알게 되었고 그렇게 예영이를 중심으로 프로그래밍에 관심이 많은 저희 셋이 모이게 되었습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  '이 앱은 어떠한 과정을 통해 만들어졌나요?',
                  style: TextStyle(
                      fontFamily: 'SCDream6',
                      color: Colors.black
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "정말 아무 생각 없이 편한 상태에서 여러가지 아이디어를 낸 후 저희끼리 투표를 하여 '사진 속 개인정보를 직접 지워주는 앱'이 있었으면 좋겠다는 생각에 Data-tective가 처음으로 구상되었습니다. \n",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '예선 제출이 열리기 전부터 제출 양식을 다운 받아 매일 여름 방학에 매일 카톡을 하고 이틀에서 사흘 사이에 꼭 한번씩 온라인으로 모여 아이디어를 구체화 하였습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "그렇게 2021 삼성 주니어 SW 대회에 예선 제출을 마치고 떨리는 마음으로 예선 결과를 확인하였습니다.",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '예선 통과라는 것을 확인한 뒤 저희는 이 앱을 꼭 완성도 있게 완성하자고 결심은 했지만 셋 다 프로그래밍에 관심만 많고 경험이나 실력이 없어 앞이 매우 막막했습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "매일 새벽 4시~5시까지 플러터에 대하여 공부를 하고 개발환경을 세팅하였습니다.",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '예제를 돌려보며 처음 보는 장문의 빨간 에러 메시지들 때문에 과연 우리가 이 앱을 만들 수 있을까 하는 불안감이 생겨났습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "그런 상황 속에서 부트 데이가 진행이 되고 멘토님들을 만나 매주 멘토링을 했습니다.",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '같이 예제들을 실행하고 에러들도 해결하며 어느정도 어떻게 해야할지 감을 잡게 되었습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "여전히 매일 밤을 새가며 플러터에 대해 공부하고 앱도 제대로 만들기 시작했습니다.\n",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '그러나 저희 모두 앱을 만들어 본 적이 없었기 때문에 앱의 디자인, 코드 정리 등이 엉망이었습니다.\n',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          "그때마다 멘토님들의 도움과 피드백이 있었기 때문에 저희는 이 앱을 완성 시킬 수 있었습니다.\n",
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                        Text(
                          '어떻게 하면 사용자 친화적인 앱을 만들 수 있는지, 어떤 기능을 포기하고, 어떤 기능을 추가해야할지 저희끼리 했다면 불가능 했을 것을 멘토님들의 도움이 있었기 때문에 이 앱을 완성시킬 수 있었습니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: const Text(
                  'Special Thanks to.',
                  style: TextStyle(
                      fontFamily: 'Staatliches-Regular',
                      color: Colors.black
                  ),),
                initiallyExpanded: false,
                backgroundColor: Colors.transparent,
                iconColor: const Color(0xff647dee),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Data-tective를 완성할 수 있도록 끝없이 도와주시고 넘치는 응원을 해주신 김의윤 멘토님 양원철 멘토님께 정말 감사드립니다.',
                          style: TextStyle(
                              fontFamily: 'SCDream4',
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  children: const [
                    Text(
                      'Data-tective를 이용해주셔서 감사합니다.',
                      style: TextStyle(
                        fontFamily: 'SCDream4',
                        fontSize: 15
                      ),),
                    Text(
                      '앞으로도 많은 이용 부탁드립니다!',
                      style: TextStyle(
                          fontFamily: 'SCDream4',
                          fontSize: 15
                      ),),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ];
    return Scaffold(
      appBar: NewGradientAppBar(
        elevation: 0,
        gradient: const LinearGradient(
          colors: [Color(0xff647dee), Color(0xff7f53ac)]
        ),
        title: const Text(
          'Data-tective',
          style: TextStyle(
            fontFamily: 'Staatliches-Regular'
          ),),
        actions: [
          IconButton(onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  if (_selectedIndex==0) {
                    return AlertDialog(
                      title: const Text('References', style: TextStyle(fontFamily: 'Staatliches-Regular'),),
                      content: const Text(
                        '이 앱이 개발될 때 도움을 준 다른 소스들입니다.',
                        style: TextStyle(
                          fontFamily: 'SCDream4'
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('알겠습니다',
                            style: TextStyle(
                              fontFamily: 'SCDream4',
                              color: Color(0xff647dee)
                            ),),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
                  else if (_selectedIndex==1) {
                    return AlertDialog(
                      title: const Text('사진 업로드', style: TextStyle(fontFamily: 'SCDream6')),
                      content: const Text(
                          "갤러리에서 이미지를 불러오거나 카메라를 사용해 직접 사진을 찍을 수 있습니다.\n업로드 된 사진은 AI 탐정이 직접 검열해 줍니다",
                        style: TextStyle(
                          fontFamily: 'SCDream4'
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('알겠습니다',
                            style: TextStyle(
                                fontFamily: 'SCDream4',
                                color: Color(0xff647dee)
                            ),),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
                  else {
                    return AlertDialog(
                      title: const Text('자세한 설명', style: TextStyle(fontFamily: 'SCDream6',)),
                      content: const Text(
                          '이 앱에 대한 설명입니다.',
                        style: TextStyle(
                          fontFamily: 'SCDream4'
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('알겠습니다',
                            style: TextStyle(
                                fontFamily: 'SCDream4',
                                color: Color(0xff647dee)
                            ),),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
                }
            );
          },
              icon: const Icon(Icons.help_outline))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ConvexAppBar(
        top: -25,
        backgroundColor: const Color(0xff647dee),
        gradient: const LinearGradient(
            colors: [Color(0xff7f53ac), Color(0xff647dee), Color(0xff7f53ac)]
        ),
        // activeColor: const Color(0xffff9d00),
        style: TabStyle.fixed,
        elevation: 0,
        activeColor: const Color(0xffEBEDD0),
        items: [
          const TabItem(icon: Icons.star, title: 'References'),
          TabItem(icon: Image.asset('assets/logo-white.png',),), //이미지가 정사각형이 아니라서 동그라미를 넘어가는 것 같아요 나중에 이미지 새로 만들고 다시 넣어보겟습니다
          const TabItem(icon: Icons.live_help, title: 'Info'),
        ],
        initialActiveIndex: 1,//optional, default as 0
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}