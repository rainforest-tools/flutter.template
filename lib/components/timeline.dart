import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_website/components/bulletList.dart';
import 'package:personal_website/models/event.dart';

class Timeline extends StatelessWidget {
  const Timeline({
    Key key,
    @required this.events,
    this.direction = Axis.horizontal,
    this.controller,
    @required this.timestampStyle,
    @required this.nameStyle,
    @required this.descriptionStyle
  }) : super(key: key);

  final List<Event> events;
  final Axis direction;
  final ScrollController controller;
  final TextStyle timestampStyle;
  final TextStyle nameStyle;
  final TextStyle descriptionStyle;

  @override
  Widget build(BuildContext context) {
    events.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    if (direction == Axis.horizontal)
      return new ListView.builder(
        controller: controller,
        scrollDirection: direction,
        itemCount: events.length,
        itemExtent: 300,
        itemBuilder: (_, index) =>
          TimelineItem(
            event: events[index], 
            direction: direction,
            isReversed: index.isEven ? false : true,
            timestampStyle: timestampStyle, 
            nameStyle: nameStyle, 
            descriptionStyle: descriptionStyle,
          )
      );
    else
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: events.map((event) => TimelineItem(
          event: event, 
          direction: direction,
          isReversed: events.indexOf(event).isEven ? false : true,
          timestampStyle: timestampStyle, 
          nameStyle: nameStyle, 
          descriptionStyle: descriptionStyle
        )).toList()
      );
  }
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({ 
    @required this.event,
    this.direction = Axis.horizontal,
    this.isReversed = false,
    @required this.timestampStyle,
    @required this.nameStyle,
    @required this.descriptionStyle
  });
  final Event event;
  final Axis direction;
  final bool isReversed;
  final TextStyle timestampStyle;
  final TextStyle nameStyle;
  final TextStyle descriptionStyle;

  @override
  Widget build(BuildContext context) {
    final timestamp = Text(
      new DateFormat('yyyy-MM').format(event.timestamp),
      textAlign: direction == Axis.vertical && !isReversed ? TextAlign.right : null,
      style: timestampStyle
    );
    final item = Hero(
      tag: 'timeline_item_${event.title}',
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              event.title, 
              style: nameStyle
            ),
          ),
          subtitle: _getDescriptionWidget(context, event.description)
        ),
      ),
    );

    final painter = new _TimelinePainter(
      color: Theme.of(context).primaryColor,
      direction: direction
    );

    if (direction == Axis.vertical) {
      final widgets = <Widget>[
        Flexible(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: timestamp,
            )
          )
        ), 
        Flexible(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: item
          )
        )
      ];
      return CustomPaint(
        painter: painter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: isReversed ? widgets.reversed.toList() : widgets
        ),
      );
    }
    else
      return Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Column(
          children: <Widget>[
            timestamp,
            Padding(
              padding: const EdgeInsets.all(10),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: CustomPaint(
                  painter: painter,
                ),
              ),
            ),
            item
          ]
        )
      );
  }

  Widget _getDescriptionWidget (BuildContext context, List<String> description) {
    switch (description.length) {
      case 0:
        return Text('');
      case 1:
        return Text(
          event.description.first,
          style: descriptionStyle
        );
      default:
        return BulletList(
          texts: description,
          textStyle: descriptionStyle
        );
    }
  }
}

class _TimelinePainter extends CustomPainter {

  _TimelinePainter({
    Key key,
    this.color,
    this.direction = Axis.horizontal,
    Widget child
  }) :super();

  final color;
  final direction;

  final Paint strokePaint = Paint()
                            ..style = PaintingStyle.stroke;
  final Paint filledPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    filledPaint.color = color;

    final offsetCenter = direction == Axis.horizontal ? size.topCenter(Offset(0, 0)) : size.center(Offset(0, 0));
    final startPoint = direction == Axis.horizontal ? size.centerLeft(Offset(0, 0)) : size.topCenter(Offset(0, 0));
    final endPoint = direction == Axis.horizontal ? size.centerRight(Offset(0, 0)).translate(50, 0) : size.bottomCenter(Offset(0, 0));
    
    canvas.drawCircle(offsetCenter, 5, filledPaint);
    canvas.drawCircle(offsetCenter, 7, strokePaint);
    canvas.drawLine(startPoint, endPoint, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  
}