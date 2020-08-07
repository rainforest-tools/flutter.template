import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_website/components/SocialBar.dart';
import 'package:personal_website/components/projectCard.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/project.dart';
import 'package:personal_website/responsive.dart';
import 'package:personal_website/routes/routes.dart';
import 'package:personal_website/util.dart';
import 'package:provider/provider.dart';

enum Mode {GRID, DETAIL}

class ProjectsPage extends StatefulWidget {

  ProjectsPage({
    Key key,
    this.mode = Mode.GRID,
    this.projectId
  }) : super(key: key);

  final Mode mode;
  final String projectId;

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}
class _ProjectsPageState extends State<ProjectsPage> with TickerProviderStateMixin {
  FixedExtentScrollController _wheelScrollController;
  Project _selectedProject;

  AnimationController _animationController;
  Animation _tween;

  @override
  void initState() {
    super.initState();
    final tagsNotifier = Provider.of<TagsNotifier>(context, listen: false);

    var initialItem = tagsNotifier.filtedProjects.indexWhere((project) => getIdFromUniqueKey(project.id) == widget.projectId);
    if (initialItem == -1) initialItem = 0;
    _wheelScrollController = new FixedExtentScrollController(
      initialItem: initialItem
    );
    _selectedProject = tagsNotifier.filtedProjects[initialItem];

    _animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this, lowerBound: 0, upperBound: 1);
    _animationController..addListener(() {
      setState(() {});
    });
    _tween = new Tween<double>(begin: 0, end: 1).animate(
      new CurvedAnimation(
        parent: _animationController, 
        curve: Interval(0.5, 1, curve: Curves.easeOut)
      )
    );
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _wheelScrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routesNotifier = Provider.of<Routes>(context);
    final tagsNotifier = Provider.of<TagsNotifier>(context);
    return DefaultLayout(
      appBar: AppBar(
        title: Text(
          'Projects'
        ),
        actions: <Widget>[
          Hero(tag: 'socialLinks', child: new SocialBar())
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: <Widget>[
                if (widget.mode == Mode.DETAIL) FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(30), left: Radius.circular(30)),
                  ),
                  color: Theme.of(context).dividerColor,
                  child: SizedBox(height: 60, child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground,)),
                  onPressed: () => Navigator.of(context).pushNamed('/projects'),
                ),
                Expanded(
                  child: Container(
                    constraints: new BoxConstraints(
                      minHeight: 60,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Wrap(
                      spacing: 10,
                      direction: Axis.horizontal,
                      children: tagsNotifier.selectedTags.map((tag) => ActionChip(
                        avatar: tag.icon != null ? Icon(tag.icon) : null,
                        backgroundColor: tag.isSelected ? Theme.of(context).accentColor : null,
                        label: Text(tag.name),
                        onPressed: () => _onChipPressed(tag, tagsNotifier)
                      )).toList()
                    ),
                    decoration: new BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(30), left: Radius.circular(30)),
                    ),
                  ),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(30), left: Radius.circular(30)),
                  ),
                  color: Theme.of(context).dividerColor,
                  child: SizedBox(height: 60, child: Icon(Icons.search, color: Theme.of(context).colorScheme.onBackground,)),
                  onPressed: () {
                    showSearch(
                      context: context, 
                      delegate: ProjectSearch(tagsNotifier.filtedProjects)
                    );
                  }
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 30),
            child: _getProjectsPageBody(context),
          )
        )
      )
    );
  }

  Widget _getProjectsPageBody(BuildContext context) {
    final routesNotifier = Provider.of<Routes>(context);
    final tagsNotifier = Provider.of<TagsNotifier>(context);
    switch (widget.mode) {
      case Mode.DETAIL:
        if (!ResponsiveHelper().isXsmall(context)) return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(
              flex: ResponsiveHelper().valueGiver(context, 1, 1, 2, 3, 3),
              child: Center(
                child: ListWheelScrollView.useDelegate(
                  controller: _wheelScrollController,
                  physics: new FixedExtentScrollPhysics(),
                  diameterRatio: 50,
                  squeeze: 0.9,
                  offAxisFraction: 0.9,
                  itemExtent: _getListWheelScrollViewItemExtent(context, 0.8),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: tagsNotifier.filtedProjects.length,
                    builder: (context, index) {
                      final project = tagsNotifier.filtedProjects[index.abs()];

                      return Hero(
                        tag: 'projectCard ${getIdFromUniqueKey(project.id)}',
                        child: AspectRatio(
                          aspectRatio: ResponsiveHelper().ratio(context),
                          child: project.imageUrl != null ? 
                            Card(
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(project.imageUrl)
                              ),
                            ) : Card(
                              color: Theme.of(context).accentColor,
                              child: Center(child: Icon(Icons.image))
                            ),
                        ),
                      );
                    }
                  ),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      // _animationController.reverse().whenComplete(() {
                      //   _selectedProject = projects[value];
                      //   _animationController.forward();
                      // });
                      _animationController.reset();
                      _selectedProject = tagsNotifier.filtedProjects[value];
                      _animationController.forward();
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width / 20, -MediaQuery.of(context).size.height / 100),
                child: Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4(
                    1, 0, 0, 0,
                    0, _tween.value, 0, 0,
                    0, 0, 1, 0,
                    0, 0, 0, 1,
                  ),
                  child: Opacity(
                    opacity: _animationController.value,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _selectedProject.name,
                              style: Theme.of(context).textTheme.headline6.apply(
                                color: Theme.of(context).primaryColor
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                _selectedProject.timestamp.length == 1 ?
                                  new DateFormat('yyyy 年 MM 月').format(_selectedProject.timestamp.first) :
                                  '${new DateFormat('yyyy 年 MM 月').format(_selectedProject.timestamp.first)} - ${new DateFormat('yyyy 年 MM 月').format(_selectedProject.timestamp.last)}',
                                style: Theme.of(context).textTheme.subtitle2
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                _selectedProject.description,
                                style: Theme.of(context).textTheme.bodyText1
                              ),
                            ),
                            ProjectCardActions(project: _selectedProject, isLabelShowed: false,),
                            Flexible(child: FractionallySizedBox(heightFactor: 0.1)),
                            Wrap(
                              spacing: 10,
                              direction: Axis.horizontal,
                              children: _selectedProject.tags.map((tag) => ActionChip(
                                avatar: tag.icon != null ? Icon(tag.icon) : null,
                                backgroundColor: tag.isSelected ? Theme.of(context).accentColor : null,
                                label: Text(tag.name),
                                onPressed: () => _onChipPressed(tag, tagsNotifier)
                              )).toList()
                            )
                          ]
                        ),
                      )
                    ),
                  ),
                ),
              ),
            )
          ],
        );
        return ListView(
          children: <Widget>[
            Hero(
              tag: 'projectCard ${getIdFromUniqueKey(_selectedProject.id)}',
              child: _selectedProject.imageUrl != null ? 
                Card(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(_selectedProject.imageUrl)
                  ),
                ) : AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Card(
                    color: Theme.of(context).accentColor,
                    child: Center(child: Icon(Icons.image))
                  ),
                ),
            ),
            Text(
              _selectedProject.name,
              style: Theme.of(context).textTheme.headline6.apply(
                color: Theme.of(context).primaryColor
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _selectedProject.timestamp.length == 1 ?
                  new DateFormat('yyyy 年 MM 月').format(_selectedProject.timestamp.first) :
                  '${new DateFormat('yyyy 年 MM 月').format(_selectedProject.timestamp.first)} - ${new DateFormat('yyyy 年 MM 月').format(_selectedProject.timestamp.last)}',
                style: Theme.of(context).textTheme.subtitle2
              ),
            ),
            Text(
              _selectedProject.description,
              style: Theme.of(context).textTheme.bodyText1
            ),
            ProjectCardActions(project: _selectedProject, isLabelShowed: false,),
            Spacer(),
            Wrap(
              spacing: 10,
              direction: Axis.horizontal,
              children: _selectedProject.tags.map((tag) => ActionChip(
                avatar: tag.icon != null ? Icon(tag.icon) : null,
                backgroundColor: tag.isSelected ? Theme.of(context).accentColor : null,
                label: Text(tag.name),
                onPressed: () => _onChipPressed(tag, tagsNotifier)
              )).toList()
            )
          ]
        );
      default:
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper().valueGiver<int>(context, 1, 1, 2, 3, 5),
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            childAspectRatio: 1 / ResponsiveHelper().valueGiver(context, 1.5, 1.5, 1.4, 1.4, 1.4)
          ), 
          itemCount: tagsNotifier.filtedProjects.length,
          itemBuilder: (_, index) => GestureDetector(
            onTap: () => routesNotifier.router.navigateTo(
              context, 
              '/projects/${getIdFromUniqueKey(tagsNotifier.filtedProjects[index].id)}?mode=detail'
            ),
            child: ProjectCard(project: tagsNotifier.filtedProjects[index])
          )
        );
    }
  }

  void _onChipPressed(Tag tag, TagsNotifier tagsNotifier) {
    if (tagsNotifier.selectedTags.contains(tag)) tagsNotifier.remove(tag);
    else tagsNotifier.add(tag);
    final index = tagsNotifier.filtedProjects.indexOf(_selectedProject);
    setState(() {
      if (index == -1) _selectedProject = tagsNotifier.filtedProjects.first;
    });
    _wheelScrollController.jumpToItem(index);
  }

  double _getListWheelScrollViewItemExtent(BuildContext context, double ratio) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width >= height) return height * ratio;
    else return width * ratio;
  }
}

class ProjectSearch extends SearchDelegate<Project> {
  final List<Project> projects;

  ProjectSearch(this.projects);

  @override
  List<Widget> buildActions(BuildContext context) {
    final tagsNotifier = Provider.of<TagsNotifier>(context);
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () { 
          query = '';
          tagsNotifier.reset();
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back), 
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final tagsNotifier = Provider.of<TagsNotifier>(context);
    final results = tagsNotifier.filtedProjects.where((project) => project.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: _getProjectChips(context, tagsNotifier.selectedTags)
        ),
        Flexible(
          child: _getResultsListView(context, results)
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final tagsNotifier = Provider.of<TagsNotifier>(context);
    final results = tagsNotifier.filtedProjects.where((project) => project.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: _getProjectChips(context, tagsNotifier.selectedTags)
        ),
        Flexible(
          child: _getResultsListView(context, results)
        ),
      ],
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.from(
      colorScheme: Theme.of(context).colorScheme,
      textTheme: Theme.of(context).textTheme
    );
  }

  Widget _getResultsListView(BuildContext context, List<Project> results) {
    final routesNotifier = Provider.of<Routes>(context);
    return ListView(
      children: results.map((result) => ListTile(
        onTap: () => routesNotifier.router.navigateTo(
          context, 
          '/projects/${getIdFromUniqueKey(result.id)}?mode=detail'
        ),
        leading: AspectRatio(
          aspectRatio: 4 / 3,
          child: result.imageUrl != null ? Image(
            image: AssetImage(result.imageUrl),
            fit: BoxFit.cover,
          ) : Card(
            color: Theme.of(context).accentColor,
            child: Center(child: Icon(Icons.image))
          ),
        ),
        title: Text(
          result.name,
          style: Theme.of(context).textTheme.headline6.apply(
            color: Theme.of(context).primaryColor
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(result.description),
            _getProjectChips(context, result.tags)
          ],
        ),
      )).toList(),
    );
  }

  Widget _getProjectChips(BuildContext context, List<Tag> tags) {
    final tagsNotifier = Provider.of<TagsNotifier>(context);
    return Wrap(
      spacing: 10,
      direction: Axis.horizontal,
      children: tags.map((tag) => ActionChip(
        avatar: tag.icon != null ? Icon(tag.icon) : null,
        backgroundColor: tag.isSelected ? Theme.of(context).accentColor : null,
        label: Text(tag.name),
        onPressed: () {
          if (tagsNotifier.selectedTags.contains(tag)) tagsNotifier.remove(tag);
          else tagsNotifier.add(tag);
        }
      )).toList()
    );
  }
}