import 'package:flutter/material.dart';
import 'package:personal_website/components/bulletList.dart';
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
        appBar: AppBar(
          title: Text(
            'Rainforest',
            // style: Theme.of(context).textTheme.headline6,
          ),
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
                                  style: Theme.of(context).textTheme.headline2.apply(
                                    color: Theme.of(context).primaryColor,
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    '研究生＠台大土木電腦輔助工程組\nSpecialize in ML/DL, Frontend',
                                    style: Theme.of(context).textTheme.subtitle1.apply(
                                      color: Theme.of(context).textTheme.subtitle1.color.withAlpha(150)
                                    )
                                  ),
                                ),
                                BulletList(
                                  texts: [
                                    '熱衷學習、使用各種前端框架開發',
                                    '注重良好 UI/UX',
                                    '質感、美感偏執，希望能參與各種酷炫視覺效果之應用開發'
                                  ],
                                  textStyle: Theme.of(context).textTheme.headline6,
                                )
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
                        child: Text(
                          '經歷', 
                          style: Theme.of(context).textTheme.headline3
                        )
                      ),
                      Flexible(child: FractionallySizedBox(heightFactor: 0.2,)),
                      Flexible(
                        flex: 2,
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
                    return SkillCard(skill: skills[index],);
                  },
                  childCount: skills.length,
                ), 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper().columns(context, 1, 1, 3, 4, 5),
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                )
              ),
            )
          ],
        ));
  }
}
