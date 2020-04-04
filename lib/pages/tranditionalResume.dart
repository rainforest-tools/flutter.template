import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:personal_website/components/SocialBar.dart';
import 'package:personal_website/components/bulletList.dart';
import 'package:personal_website/components/skillCard.dart';
import 'package:personal_website/components/timeline.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/event.dart';
import 'package:personal_website/models/settings.dart';
import 'package:personal_website/models/skill.dart';
import 'package:personal_website/responsive.dart';
import 'package:provider/provider.dart';

class TranditionalResume extends StatefulWidget {
  TranditionalResume({Key key}) : super(key: key);

  @override
  _TranditionalResumeState createState() => _TranditionalResumeState();
}

class _TranditionalResumeState extends State<TranditionalResume> {
  GlobalKey globalKey = GlobalKey();
  bool _isDragging;

  @override
  void initState() {
    super.initState();
    _isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = Hero(
      tag: 'profileImage',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Image(
          image: AssetImage('assets/images/profile.JPG'),
          fit: BoxFit.cover,
        ),
      ),
    );

    final profile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: 'profile_name',
          child: Text(
            '鄭羽霖', 
            style: Theme.of(context).textTheme.headline6.apply(
              color: Theme.of(context).primaryColor,
            )
          ),
        ),
        Hero(
          tag: 'profile_job_title',
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '研究生＠台大土木電腦輔助工程組\nSpecialize in ML/DL, Frontend',
              style: Theme.of(context).textTheme.overline.apply(
                color: Theme.of(context).textTheme.subtitle1.color.withAlpha(150)
              )
            ),
          ),
        ),
        Hero(
          tag: 'profile_description',
          child: BulletList(
            texts: [
              '熱衷學習、使用各種前端框架開發',
              '注重良好 UI/UX',
              '質感、美感偏執，希望能參與各種酷炫視覺效果之應用開發'
            ],
            textStyle: Theme.of(context).textTheme.overline,
          ),
        ),
        // Hero(tag: 'socialLinks', child: new SocialBar(iconSize: 15,)),
      ],
    );
    final experienceTimeline = new Timeline(
      events: events.reversed.toList(),
      direction: Axis.vertical,
      timestampStyle: Theme.of(context).textTheme.overline,
      nameStyle: Theme.of(context).textTheme.caption.apply(
        color: Theme.of(context).primaryColor
      ),
      descriptionStyle: Theme.of(context).textTheme.overline.apply(
        fontSizeFactor: ResponsiveHelper().valueGiver(context, 0.8, 1, 1, 1, 1)
      ),
    );
    
    return DefaultLayout(
      appBar: AppBar(
        title: Text(
          'Rainforest',
        ),
        actions: <Widget>[
          _createDraggable(SocialBarPosition.APPBAR, context)
        ],
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: ResponsiveHelper().isXsmall(context) ? 0 : MediaQuery.of(context).size.height / 20),
              child: RepaintBoundary(
                key: globalKey,
                child: Transform.scale(
                  scale: ResponsiveHelper().valueGiver(context, 1, 1, 1, 1, 1),
                  child: AspectRatio(
                    aspectRatio: 210 / 297,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Scaffold(
                          body: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Align(alignment: Alignment.bottomCenter , child: Text(
                                '1',
                                style: Theme.of(context).textTheme.caption,
                              )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: FractionallySizedBox(
                                              widthFactor: 0.8,
                                              heightFactor: 0.8,
                                              child: ClipRRect(
                                                child: profileImage
                                              ),
                                            ),
                                          )
                                        ),
                                        Flexible(child: profile)
                                      ]
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Hero(tag: 'experience', child: Text(
                                                  '經歷',
                                                  style: Theme.of(context).textTheme.subtitle2,
                                                ))
                                              ),
                                              Flexible(child: experienceTimeline),
                                            ],
                                          ),
                                        ),
                                        Flexible(fit: FlexFit.tight, child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text('技能', style: Theme.of(context).textTheme.subtitle2,)
                                            ),
                                            Flexible(
                                              child: ListView.builder(
                                                itemCount: skills.length,
                                                itemBuilder: (_, index) => ListTile(
                                                  dense: true,
                                                  leading: Hero(tag: 'skill_${skills[index].name}_icon', child: Icon(skills[index].icon)),
                                                  title: Align(
                                                    alignment: Alignment(-1.2, 0),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      child: Hero(
                                                        tag: 'skill_${skills[index].name}_name',
                                                        child: Text(
                                                          skills[index].name,
                                                          style: Theme.of(context).textTheme.caption.apply(
                                                            color: Theme.of(context).primaryColor
                                                          )
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  subtitle: Align(
                                                    alignment: Alignment(-1.2, 0),
                                                    child: Hero(
                                                      tag: 'skill_${skills[index].name}_description', 
                                                      child: getDescriptionWidget(
                                                        context, 
                                                        skills[index].description, 
                                                        Theme.of(context).textTheme.overline.apply(
                                                          fontSizeFactor: ResponsiveHelper().valueGiver(context, 0.8, 1, 1, 1, 1)
                                                        )
                                                      )
                                                    ),
                                                  ),
                                                )
                                              ),
                                            ),
                                          ],
                                        ))
                                      ]
                                    )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                )
              ),
            ),
          ),
          ...alignments.map((e) => mapSocialBarPositionWithAlignment(e)).map((e) => _createDraggable(e, context)).where((c) => c != null).toList()
        ],
      ),
    );
  }

  final alignments = [
    Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight,
    Alignment.centerLeft, Alignment.center, Alignment.centerRight,
    Alignment.topLeft, Alignment.topCenter, Alignment.topRight,
  ];

  Widget _createDraggable(SocialBarPosition position, BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    final alignment = alignments.firstWhere(
      (element) => position.toString().split('.').last.toLowerCase() == element.toString().toLowerCase(),
      orElse: () {},
    );
    if (alignment == null) {
      switch (position) {
        case SocialBarPosition.APPBAR:
          return settingsNotifier.settings.socialBarPosition == position ? Draggable(
            data: position,
            feedback: Hero(tag: 'socialLinks', child: new SocialBar()),
            childWhenDragging: _createPlaceHolder(context, Theme.of(context).primaryColor),
            child: Hero(tag: 'socialLinks', child: new SocialBar()),
            onDragStarted: () => setState(() {
              _isDragging = true;
            }),
            onDragEnd: (details) => setState(() {
              _isDragging = false;
            }),
            onDraggableCanceled: (velocity, offset) => setState(() {
              _isDragging = false;
            }),
            onDragCompleted: () => setState(() {
              _isDragging = false;
            }),
          ) : _createDragTarget(context, position);
        default:
          break;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: alignment,
        child: settingsNotifier.settings.socialBarPosition == position ? Draggable(
          data: position,
          feedback: Hero(tag: 'socialLinks', child: new SocialBar(isCollapsable: true, isCollapsed: true,)),
          childWhenDragging: _createPlaceHolder(context, Theme.of(context).primaryColor),
          child: Hero(tag: 'socialLinks', child: new SocialBar(isCollapsable: true, isCollapsed: true,)),
          onDragStarted: () => setState(() {
            _isDragging = true;
          }),
          onDragEnd: (details) => setState(() {
            _isDragging = false;
          }),
          onDraggableCanceled: (velocity, offset) => setState(() {
            _isDragging = false;
          }),
          onDragCompleted: () => setState(() {
            _isDragging = false;
          }),
        ) : _createDragTarget(context, position)
      ),
    );
  }

  Widget _createDragTarget (BuildContext context, SocialBarPosition position) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    return DragTarget<SocialBarPosition>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        settingsNotifier.setSettings(SettingsEnum.socialBarPosition, position);
      },
      builder: (context, candidateData, rejectedData) {
        if (_isDragging) return _createPlaceHolder(context, Theme.of(context).accentColor);
      },
    );
  }

  Widget _createPlaceHolder (BuildContext context, Color color) => Container(
    width: 56,
    height: 56,
    decoration: new BoxDecoration(
      color: Colors.transparent,
      boxShadow: [
        BoxShadow(
          color: color,
          offset: const Offset(0.0, 0.0),
        ),
        BoxShadow(
          color: Theme.of(context).backgroundColor,
          offset: const Offset(0.0, 0.0),
          spreadRadius: -12.0,
          blurRadius: 12.0,
        ),
      ],
      border: Border.all(
        width: 1,
        style: BorderStyle.solid,
        color: color
      )
    ),
  );

  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    try {
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
    } catch (e) {
      print('error!');
    }
  }
}