import 'package:flutter/material.dart';

class Mouse extends StatefulWidget {
  @override
  _MouseState createState() => _MouseState();
}

class _MouseState extends State<Mouse> {

  double x = 0.0;
  double y = 0.0;

  void _updateLocation(TapDownDetails details) {
    setState(() {
      x = details.globalPosition.dx;
      y = details.globalPosition.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('x: '+ x.toStringAsFixed(2) + ' y: ' + y.toStringAsFixed(2)),
      ),
      body: Container(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {_updateLocation(details);},
          // child: Center(
          //   child: Container(
          //     child: Image.network('http://pngimg.com/uploads/face/face_PNG5645.png'),
          //   ),
          // ),
        ),
      ),
    );
  }
}
