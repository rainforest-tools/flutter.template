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
import 'package:personal_website/models/skill.dart';
import 'package:personal_website/responsive.dart';

class TranditionalResume extends StatefulWidget {
  TranditionalResume({Key key}) : super(key: key);

  @override
  _TranditionalResumeState createState() => _TranditionalResumeState();
}

class _TranditionalResumeState extends State<TranditionalResume> {
  GlobalKey globalKey = GlobalKey();

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
          // Hero(tag: 'socialLinks', child: new SocialBar())
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 20),
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Hero(tag: 'socialLinks', child: new SocialBar(isCollapsable: true,))
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
    );
  }

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