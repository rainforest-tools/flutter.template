import 'package:flutter/material.dart';
import 'package:personal_website/components/myAppBar.dart';
import 'package:personal_website/components/settingsForm.dart';
import 'package:personal_website/components/skillCard.dart';
import 'package:personal_website/components/timeline.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/event.dart';
import 'package:personal_website/models/skill.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        appBar: MyAppBar(
          title: Text('Rainforest'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SettingsForm()))),
          ],
        ),
        body: CustomScrollView(
          physics: ScrollPhysics(),
          // controller: ,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: Image(
                                image: AssetImage('assets/images/profile.JPG'),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Transform.translate(
                            offset: Offset(-100, 0),
                            child: RichText(
                                text: TextSpan(
                                    text: '鄭羽霖',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(
                                            fontSizeFactor: 2.0,
                                            color: Colors.tealAccent,
                                            decoration: TextDecoration.none),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: '\n研究生＠台大土木電腦輔助工程組、\n前前端及 iOS 工程師＠魏武資訊',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(
                                            fontSizeFactor: 0.5,
                                            color: Colors.white70,
                                            decoration: TextDecoration.none),
                                  )
                                ])),
                          ),
                        )
                      ])),
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Text('經歷', style: DefaultTextStyle.of(context).style.apply(
                          fontSizeFactor: 1,
                          color: Colors.white,
                          decoration: TextDecoration.none
                        ),)
                      ),
                      Flexible(child: FractionallySizedBox(heightFactor: 0.2,)),
                      Flexible(
                        child: new Timeline(
                          events: events,
                        ),
                      ),
                    ],
                  )),
            ),
            SliverPadding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(30),
                      color: Colors.white70.withOpacity(0.5),
                      child: SkillCard(skill: skills[index],),
                    );
                  },
                  childCount: skills.length,
                ), 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 30.0,
                )
              ),
            )
          ],
        ));
  }
}
