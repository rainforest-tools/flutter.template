import 'package:flutter/material.dart';
import 'package:personal_website/components/myAppBar.dart';
import 'package:personal_website/components/settingsForm.dart';
import 'package:personal_website/components/skillCard.dart';
import 'package:personal_website/components/timeline.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/event.dart';
import 'package:personal_website/models/skill.dart';
import 'package:personal_website/responsive.dart';

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
                  MaterialPageRoute(builder: (_) => SettingsForm())
                )
            ),
          ],
        ),
        body: CustomScrollView(
          physics: ScrollPhysics(),
          // controller: ,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '鄭羽霖', 
                                  style: DefaultTextStyle.of(context).style.apply(
                                    fontSizeFactor: 2.0,
                                    color: Colors.tealAccent,
                                    decoration: TextDecoration.none
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    '研究生＠台大土木電腦輔助工程組',
                                    style: DefaultTextStyle.of(context).style.apply(
                                      fontSizeFactor: 0.4,
                                      color: Colors.white60,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                                Text(
                                  '熱衷學習、使用各種前端框架開發，質感、美感偏執，希望能參與各種酷炫視覺效果、良好 UI/UX 之應用開發。',
                                  style: DefaultTextStyle.of(context).style.apply(
                                    fontSizeFactor: 0.5,
                                    color: Colors.white70,
                                    decoration: TextDecoration.none
                                  ),
                                ),
                              ],
                            ),
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
                  crossAxisCount: ResponsiveHelper().columns(context, 1, 1, 2, 3, 4),
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                )
              ),
            )
          ],
        ));
  }
}
