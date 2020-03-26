import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_website/models/event.dart';

class Timeline extends StatelessWidget {
  const Timeline({
    Key key,
    this.events
  }) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    events.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemExtent: 300,
      itemBuilder: (_, index) =>
        TimelineItem(event: events[index],)
    );
  }
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({ this.event });
  final Event event;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 30),
    child: Column(
      children: <Widget>[
        Text(new DateFormat('yyyy-MM').format(event.timestamp)),
        Padding(
          padding: const EdgeInsets.all(10),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: CustomPaint(
              painter: _TimelinePainter(),
            ),
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              event.title, 
              style: DefaultTextStyle.of(context).style.apply(
                fontSizeFactor: 1.5,
                color: Colors.tealAccent
              ),
            ),
          ),
          subtitle: Text(
            event.description,
            style: DefaultTextStyle.of(context).style.apply(
              fontSizeFactor: 1,
              color: Colors.white70
            ),
          ),
        ),
      ],
    ),
  );
}

class _TimelinePainter extends CustomPainter {

  _TimelinePainter({
    Key key,
    Widget child
  }) :super();

  final Paint strokePaint = Paint()
                            ..style = PaintingStyle.stroke;
  final Paint filledPaint = Paint()
                            ..color = Colors.tealAccent;

  @override
  void paint(Canvas canvas, Size size) {
    final offsetCenter = size.topCenter(Offset(0, 0));
    final startPoint = size.centerLeft(Offset(0, 0));
    final endPoint = size.centerRight(Offset(0, 0));
    
    canvas.drawCircle(offsetCenter, 5, filledPaint);
    canvas.drawCircle(offsetCenter, 7, strokePaint);
    canvas.drawLine(startPoint, endPoint.translate(50, 0), strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  
}