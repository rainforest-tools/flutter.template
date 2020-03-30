import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_website/components/bulletList.dart';
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
        Text(
          new DateFormat('yyyy-MM').format(event.timestamp),
          style: Theme.of(context).textTheme.subtitle2
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: CustomPaint(
              painter: _TimelinePainter(
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              event.title, 
              style: Theme.of(context).textTheme.headline6.apply(
                color: Theme.of(context).primaryColor
              )
            ),
          ),
          subtitle: _getDescriptionWidget(context, event.description)
        ),
      ],
    ),
  );

  Widget _getDescriptionWidget (BuildContext context, List<String> description) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    switch (description.length) {
      case 0:
        return Text('');
      case 1:
        return Text(
          event.description.first,
          style: textStyle
        );
      default:
        return BulletList(
          texts: description,
          textStyle: textStyle
        );
    }
  }
}

class _TimelinePainter extends CustomPainter {

  _TimelinePainter({
    Key key,
    this.color,
    Widget child
  }) :super();

  final color;

  final Paint strokePaint = Paint()
                            ..style = PaintingStyle.stroke;
  final Paint filledPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    filledPaint.color = color;

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