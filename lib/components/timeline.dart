import 'package:flutter/material.dart';
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
        Text(event.timestamp.toString()),
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