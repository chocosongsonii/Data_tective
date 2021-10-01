import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class DragToDrawRectangle extends StatefulWidget {
  const DragToDrawRectangle({Key key}) : super(key: key);

  @override
  _DragToDrawRectangleState createState() => _DragToDrawRectangleState();
}

class _DragToDrawRectangleState extends State<DragToDrawRectangle> {

  final _points = <Offset>[];
  final _rects = <Rect>[];

  Offset _start, _end;

  _scaleStartGesture(ScaleStartDetails onStart) {
    setState(() {
      _start = onStart.focalPoint;
      _points.add(_start);
    });
  }

  void _scaleUpdateGesture(ScaleUpdateDetails onUpdate) {
    setState(
          () {
        _start ??= onUpdate.focalPoint;
        _end = onUpdate.focalPoint;
      },
    );
  }

  void _scaleEndGesture(ScaleEndDetails onEnd) {
    setState(() {
      // _start = null;
      // _end = null;
      _points.add(_end);
      _rects.add(Rect.fromPoints(_start,_end));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('x: '+ _start.toString() + ' y: ' + _end.toString()),
        actions: [
          TextButton(
              onPressed: () {
                for (Offset offset in _points) {
                  print(offset);
                }
                print(_rects.length);
              },
              child: const Text('Offsets', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: InteractiveViewer(
        onInteractionStart: (ScaleStartDetails details) {_scaleStartGesture(details);},
        onInteractionUpdate: (details) =>
            _scaleUpdateGesture(details),
        onInteractionEnd: (details) =>
            _scaleEndGesture(details),
        child:
        Image.asset('assets/sticker1.png'),
        // child: CustomPaint(
        //   willChange: true,
        //   isComplex: true,
        //   painter: DrawImage(
        //     isSignature: true,
        //     backgroundColor: Colors.white,
        //     points: _points,
        //     paintHistory: _paintHistory,
        //     isDragging: _inDrag,
        //     update: UpdatePoints(
        //         start: _start,
        //         end: _end,
        //         painter: _painter,
        //         mode: PaintMode.rect),
        //   ),
        // ),
        // CanvasTouchDetector(
        //   builder: (context) => CustomPaint(
        //     painter: DrawRectangle(context),
        //   ),
        // ),
      ),
    );
  }
}

// class DrawRectangle extends CustomPainter{
//   final BuildContext context;
//
//   DrawRectangle(this.context);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);
//     // TODO: implement paint
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class Controller {
//   ///Tracks [strokeWidth] of the [Paint] method.
//   final double strokeWidth;
//
//   ///Tracks [Color] of the [Paint] method.
//   final Color color;
//
//   ///Tracks [PaintingStyle] of the [Paint] method.
//   final PaintingStyle paintStyle;
//
//   ///Tracks [PaintMode] of the current [Paint] method.
//   final PaintMode mode;
//
//   ///Any text.
//   final String text;
//
//   ///Constructor of the [Controller] class.
//   const Controller(
//       {this.strokeWidth = 4.0,
//         this.color = Colors.red,
//         this.mode = PaintMode.rect,
//         this.paintStyle = PaintingStyle.stroke,
//         this.text = ""});
//
//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
//
//     return o is Controller &&
//         o.strokeWidth == strokeWidth &&
//         o.color == color &&
//         o.paintStyle == paintStyle &&
//         o.mode == mode &&
//         o.text == text;
//   }
//
//   @override
//   int get hashCode {
//     return strokeWidth.hashCode ^
//     color.hashCode ^
//     paintStyle.hashCode ^
//     mode.hashCode ^
//     text.hashCode;
//   }
//
//   ///copyWith Method to access immutable controller.
//   Controller copyWith(
//       {double strokeWidth,
//         Color color,
//         PaintMode mode,
//         PaintingStyle paintingStyle,
//         String text}) {
//     return Controller(
//         strokeWidth: strokeWidth ?? this.strokeWidth,
//         color: color ?? this.color,
//         mode: mode ?? this.mode,
//         paintStyle: paintingStyle ?? paintStyle,
//         text: text ?? this.text);
//   }
// }
//
// class PaintInfo {
//   ///Mode of the paint method.
//   PaintMode mode;
//
//   ///Used to save specific paint utils used for the specific shape.
//   Paint painter;
//
//   ///Used to save offsets.
//   ///Two point in case of other shapes and list of points for [FreeStyle].
//   List<Offset> offset;
//
//   ///Used to save text in case of text type.
//   String text;
//
//   ///In case of string, it is used to save string value entered.
//   PaintInfo({this.offset, this.painter, this.text, this.mode});
// }
//
// class DrawImage extends CustomPainter {
//   ///Converted image from [ImagePainter] constructor.
//   final Image image;
//
//   ///Keeps track of all the units of [PaintHistory].
//   final List<PaintInfo> paintHistory;
//
//   ///Keeps track of points on currently drawing state.
//   final UpdatePoints update;
//
//   ///Keeps track of freestyle points on currently drawing state.
//   final List<Offset> points;
//
//   ///Keeps track whether the paint action is running or not.
//   final bool isDragging;
//
//   ///Flag for triggering signature mode.
//   final bool isSignature;
//
//   ///The background for signature painting.
//   final Color backgroundColor;
//
//   ///Constructor for the canvas
//   DrawImage(
//       {this.image,
//         this.update,
//         this.points,
//         this.isDragging = false,
//         this.isSignature = false,
//         this.backgroundColor,
//         this.paintHistory});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (isSignature) {
//       ///Paints background for signature.
//       canvas.drawRect(
//           Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
//           Paint()
//             ..style = PaintingStyle.fill
//             ..color = backgroundColor);
//     } else {
//       ///paints [ui.Image] on the canvas for reference to draw over it.
//       paintImage(
//         canvas: canvas,
//         // image: ,
//         filterQuality: FilterQuality.high,
//         rect: Rect.fromPoints(
//           const Offset(0, 0),
//           Offset(size.width, size.height),
//         ),
//       );
//     }
//
//     ///paints all the previoud paintInfo history recorded on [PaintHistory]
//     for (var item in paintHistory) {
//       final _offset = item.offset;
//       final _painter = item.painter;
//         canvas.drawRect(
//               Rect.fromPoints(_offset[0], _offset[1]), _painter);
//     }
//
//     ///Draws ongoing action on the canvas while indrag.
//     if (isDragging) {
//       final _start = update.start;
//       final _end = update.end;
//       final _painter = update.painter;
//       switch (update.mode) {
//         case PaintMode.rect:
//           canvas.drawRect(Rect.fromPoints(_start, _end), _painter);
//     }
//
//     ///Draws all the completed actions of painting on the canvas.
//   }
//
//   ///Draws line as well as the arrowhead on top of it.
//   ///Uses [strokeWidth] of the painter for sizing.
//   void drawArrow(Canvas canvas, Offset start, Offset end, Paint painter) {
//     final arrowPainter = Paint()
//       ..color = painter.color
//       ..strokeWidth = painter.strokeWidth
//       ..style = PaintingStyle.stroke;
//     canvas.drawLine(start, end, painter);
//     final _pathOffset = painter.strokeWidth / 15;
//     var path = Path()
//       ..lineTo(-15 * _pathOffset, 10 * _pathOffset)
//       ..lineTo(-15 * _pathOffset, -10 * _pathOffset)
//       ..close();
//     canvas.save();
//     canvas.translate(end.dx, end.dy);
//     canvas.rotate((end - start).direction);
//     canvas.drawPath(path, arrowPainter);
//     canvas.restore();
//   }
//
//   ///Draws dashed path.
//   ///It depends on [strokeWidth] for space to line proportion.
//   Path _dashPath(Path path, double width) {
//     final dashPath = Path();
//     final dashWidth = 10.0 * width / 5;
//     final dashSpace = 10.0 * width / 5;
//     var distance = 0.0;
//     for (final pathMetric in path.computeMetrics()) {
//       while (distance < pathMetric.length) {
//         dashPath.addPath(
//           pathMetric.extractPath(distance, distance + dashWidth),
//           Offset.zero,
//         );
//         distance += dashWidth;
//         distance += dashSpace;
//       }
//     }
//     return dashPath;
//   }
//
//   @override
//   bool shouldRepaint(DrawImage oldInfo) {
//     return (oldInfo.update != update ||
//         oldInfo.paintHistory.length == paintHistory.length);
//   }
// }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }}
//
// class UpdatePoints {
//   ///Records the first tap offset,
//   final Offset start;
//
//   ///Records all the offset after first one.
//   final Offset end;
//
//   ///Records [Paint] method of the ongoing painting.
//   final Paint painter;
//
//   ///Records [PaintMode] of the ongoing painting.
//   final PaintMode mode;
//
//   ///Constructor for ongoing painthistory.
//   UpdatePoints({this.start, this.end, this.painter, this.mode});
//
//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
//
//     return o is UpdatePoints &&
//         o.start == start &&
//         o.end == end &&
//         o.painter == painter &&
//         o.mode == mode;
//   }
//
//   @override
//   int get hashCode {
//     return start.hashCode ^ end.hashCode ^ painter.hashCode ^ mode.hashCode;
//   }
// }

