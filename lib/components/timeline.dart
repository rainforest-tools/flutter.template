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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
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
  child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 300
      ),
      child: Expanded(
        child: RichText(
        text: TextSpan(
          text: event.title,
          style: DefaultTextStyle.of(context).style.apply(
            fontSizeFactor: 1.5,
            color: Colors.tealAccent
          ),
          children: <TextSpan>[
            TextSpan(
              text: '''\n${event.timestamp.toString()}''',
              style: DefaultTextStyle.of(context).style.apply(
                fontSizeFactor: 0.8,
                color: Colors.white60
              ),
            ),
            TextSpan(
              text: '''\n${event.description}''',
              style: DefaultTextStyle.of(context).style.apply(
                fontSizeFactor: 1,
                color: Colors.white70
              ),
            )
          ]
        )
      ),
    ),
  ),
    );
}