import 'package:data_tective/test.dart';
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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text(
                      'Licences',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Staatliches-Regular',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '폰트',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SCDream6',
                      ),
                    ),
                    Text(
                        '이 앱에는 에스코어가 제공한 에스코어 드림 폰트가 적용되어 있습니다.',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'SCDream4',
                        )
                    ),
                    Text(
                        '이 앱에는 Google Fonts가 제공한 Staatliches-Regular 폰트가 적용되어 있습니다.',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'SCDream4',
                        )
                    )
                  ],
                ),
              ),
            ),
          ],
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
              ),
              const SizedBox(height: 20.0),
              const Center(
                child: Text(
                    '검열할 이미지를 선택해주세요',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'SCDream4'
                  ),),
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
                      fontFamily: 'SCDream4'
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
                          fontFamily: 'SCDream4'
                      )
                  )
              ),
            ],
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DragToDrawRectangle()));
        },   // TODO: onPressed 구현 필요.
        child: const Text('Working on it!!'),
      ),
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
        backgroundColor: const Color(0xff7f53ac),
        gradient: const LinearGradient(
            colors: [Color(0xff7f53ac), Color(0xff647dee), Color(0xff7f53ac),]
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