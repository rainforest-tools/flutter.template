import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  BulletList({Key? key, required this.texts, this.bullet, this.textStyle})
      : super(key: key);

  final List<String> texts;
  final TextSpan? bullet;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    textStyle = textStyle ?? Theme.of(context).textTheme.subtitle2;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: texts.length,
        itemBuilder: (_, index) => CustomPaint(
            painter: _BulletListPainter(
                bullet: bullet ?? TextSpan(text: '●', style: textStyle)),
            child: Padding(
              padding: EdgeInsets.only(left: textStyle!.fontSize!),
              child: Text(texts[index], style: textStyle),
            )));
  }
}

class _BulletListPainter extends CustomPainter {
  _BulletListPainter({Widget? child, required this.bullet}) : super();

  final TextSpan bullet;

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter =
        TextPainter(text: bullet, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final startPoint = size.topLeft(Offset(0, 0));

    textPainter.paint(canvas, startPoint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
