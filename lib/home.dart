import 'package:data_tective/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart'
    show ImageSource;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_pick.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'mouse_event.dart';

ImagePicker picker = ImagePicker();

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 1;
  int _stickerId = 0;

  SharedPreferences _prefs;

  void sendToImagePick(BuildContext context, ImageSource sourceType, _stickerId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(sourceType, _stickerId)));
  }

  @override
  void initState() {
    super.initState();
    _loadId();
  }

  _loadId() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _stickerId = (_prefs.getInt('sticker') ?? 0);
      print(_stickerId); //TODO: 제출할 때 없애기
    });
  }

  void checkOption(int index) {
    setState(() {
      _stickerId = index;
      _prefs.setInt('sticker', _stickerId);
    });
  }

  static const List<Map<String, dynamic>> stickers = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'blur',
      'img': 'assets/sticker1.png',
    },
    <String, dynamic>{
      'name': 'heart',
      'img': 'assets/sticker2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 투명색
    ));

    List _widgetOptions = [
      GridView.count(
        crossAxisCount: 2,
        children: [
          for (int i = 0; i < stickers.length; i++)
            StickerOption(
              stickers[i]['name'] as String,
              img: stickers[i]['img'] as String,
              onTap: () => checkOption(i + 1),
              selected: i + 1 == _stickerId,
            )
        ],
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
                    sendToImagePick(context, ImageSource.gallery, _stickerId);
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
                    sendToImagePick(context, ImageSource.camera, _stickerId);
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
                      title: const Text('스티커 설정'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const [
                            Text('사진을 검열할 방법을 설정할 수 있습니다.'),
                            Text('블러, 스티커를 활용하여 여러가지 방법으로 사진을 검열해보세요.'),
                          ],
                        ),
                      ),
                    );
                  }
                  else if (_selectedIndex==1) {
                    return AlertDialog(
                      title: const Text('사진 업로드'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const [
                            Text('갤러리에서 이미지를 불러오거나 카메라를 사용해 직접 사진을 찍을 수 있습니다.'),
                            Text('업로드 된 사진은 AI 탐정이 직접 검열해 준답니다.'),
                          ],
                        ),
                      ),
                    );
                  }
                  else {   //if (_selectedIndex==2) {  // if else 구분에서 else 는 필수입니다.
                    return AlertDialog(
                      title: const Text('자세한 설명'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const [
                            Text('이 앱에 대한 설명입니다.'),
                          ],
                        ),
                      ),
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
        activeColor: const Color(0xff7f53ac),
        items: [
          const TabItem(icon: Icons.star, title: 'Sticker'),
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selected ?? false ? const Color(0xff7f53ac) : Colors.black54 ,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Staatliches-Regular'
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
