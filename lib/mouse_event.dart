import 'dart:ui';

import 'package:flutter/material.dart';

class Mouse extends StatefulWidget {
  @override
  _MouseState createState() => _MouseState();
}

class _MouseState extends State<Mouse> {

  double x = 0.0;
  double y = 0.0;

  double xStart = 0.0;
  double xEnd = 0.0;
  double yStart = 0.0;
  double yEnd = 0.0;

  Offset _start;
  Offset _end;

  List<Rect> added = [];

  double appBarHeight = AppBar().preferredSize.height;

  // void _updateLocation(TapDownDetails details) {
  //   setState(() {
  //     x = details.globalPosition.dx;
  //     y = details.globalPosition.dy;
  //   });
  // }

  // void _scaleStartGesture(DragStartDetails onStart) {
  //   print('에베ㅐㄻ져도리ㅑㅁ주ㅚ뮤ㅣㅑㅓㅠㅍ류' + added.length.toString());
  //   setState(() {
  //     xStart = onStart.globalPosition.dx;
  //     yStart = onStart.globalPosition.dy;
  //   });
  // }
  //
  // void _scaleUpdateGesture(DragUpdateDetails onUpdate) {
  //   setState(
  //         () {
  //       xEnd = onUpdate.globalPosition.dx;
  //       yEnd = onUpdate.globalPosition.dy;
  //     },
  //   );
  // }
  //
  // void _scaleEndGesture(DragEndDetails onEnd) {
  //   setState(() {
  //     added.add(Rect.fromLTRB(xStart, yStart, xEnd, yEnd));
  //     xStart = null;
  //     xEnd = null;
  //     yStart = null;
  //     yEnd = null;
  //     print('에베ㅐㄻ져도리ㅑㅁ주ㅚ뮤ㅣㅑㅓㅠㅍ류' + added.length.toString());
  //   });
  // }

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
      // _start = null;
      // _end = null;
      // added.add(Rect.fromPoints(_start,_end));
      added.add(Rect.fromLTRB(xStart, yStart-appBarHeight-MediaQuery.of(context).padding.top, xEnd, yEnd-appBarHeight-MediaQuery.of(context).padding.top));
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

  InteractiveViewer columnForBlur() {
    return InteractiveViewer(
      panEnabled: false,
      onInteractionStart: (ScaleStartDetails details) {_scaleStartGesture(details);},
      onInteractionUpdate: (details) =>
          _scaleUpdateGesture(details),
      onInteractionEnd: (details) =>
          _scaleEndGesture(details),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - appBarHeight,
        width: MediaQuery.of(context).size.width,
        child: Stack(
            children: [
              Flexible(child: Image.asset('assets/giyu.png', height: MediaQuery.of(context).size.height,)),
              for(Rect rect in added)
                Positioned(
                  top: rect.top,
                  left: rect.left,
                  child: Center(
                    child: ClipRect(
                      child: Container(
                        // alignment: Alignment.center,
                        width: rect.width,
                        height: rect.height,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
            ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('x: '+ x.toStringAsFixed(2) + ' y: ' + y.toStringAsFixed(2)),
      ),
      body: Container(
        child: columnForBlur()
        // GestureDetector(
        //   onTapDown: (TapDownDetails details) {_updateLocation(details);},
        //   // child: Center(
        //   //   child: Container(
        //   //     child: Image.network('http://pngimg.com/uploads/face/face_PNG5645.png'),
        //   //   ),
        //   // ),
        // ),
      ),
    );
  }
}
