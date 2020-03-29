final tags = {
  'VUE': new Tag(name: 'Vue'),
  'NUXT': new Tag(name: 'Nuxt'),
  'REACT': new Tag(name: 'React'),
  'NEXT': new Tag(name: 'Next'),
  'RWD': new Tag(name: 'RWD'),
  'FRONTEND': new Tag(name: 'Frontend'),
  'FIREBASE': new Tag(name: 'Firebase'),
  'MONGODB': new Tag(name: 'MongoDB'),
  'GRAPHQL': new Tag(name: 'GraphQL'),
  'BACKEND': new Tag(name: 'Backend'),
};

final projects = <Project>[
  new FrontendProject(
    timestamp: [
      new DateTime.utc(2019, 12)
    ],
    name: '未來科技展微結構設計成果展示平台',
    description: '整合訓練好的機器學習模型預測隨機產生的圖騰之力學強度，透過網頁讓參觀的民眾理解我們攤位具體的展覽內容。',
    url: 'https://github.com/r08521610/future_tech',
    deployUrl: 'https://future-tech-competition.herokuapp.com/',
    tags: [
      tags['VUE'],
      tags['NUXT'],
      tags['FRONTEND'],
      tags['FIREBASE'],
      tags['BACKEND']
    ]
  ),
  new FrontendProject(
    timestamp: [
      new DateTime.utc(2019, 12)
    ],
    name: 'APCOM 議程網頁',
    description: 'Asian Pacific Congress on Computational Mechanics (APCOM) 會議議程表，考量與會者會有行動端的需求，特別優化 RWD 的部分。',
    url: 'https://github.com/r08521610/apcom_program',
    deployUrl: 'https://r08521610.github.io/apcom_program/#/program/18',
    tags: [
      tags['VUE'],
      tags['FRONTEND'],
      tags['RWD']
    ]
  ),
  new Project(
    timestamp: [
      new DateTime.utc(2019, 5),
      new DateTime.utc(2019, 7),
    ],
    name: 'Palette Manager',
    description: '存放管理色票的網站。',
    url: 'https://github.com/b04501102/midterm_palette_manager',
    tags: [
      tags['REACT'],
      tags['NEXT'],
      tags['FRONTEND'],
      tags['MONGODB'],
      tags['GRAPHQL'],
      tags['BACKEND']
    ]
  ),
  new Project(
    timestamp: [
      new DateTime.utc(2019, 9),
      new DateTime.utc(2019, 4),
    ],
    name: 'BIM 管理平台',
    tags: [
      tags['REACT'],
      tags['FRONTEND']
    ]
  ),
  new FrontendProject(
    timestamp: [
      new DateTime.utc(2019, 7),
    ],
    name: 'Workshop Slides and Examples',
    url: 'https://github.com/b04501102/TalkDemo_20190708',
    deployUrl: 'https://talk-demo-20190708.herokuapp.com/#/',
    tags: [
      tags['VUE'],
      tags['FRONTEND']
    ]
  ),
  new CodepenProject(
    timestamp: [
      new DateTime.utc(2019, 2),
    ],
    name: 'Cards Carousel',
    url: 'https://codepen.io/rainforest80256/pen/xBwPJJ',
    tags: [
      tags['FRONTEND']
    ]
  ),
  new CodepenProject(
    timestamp: [
      new DateTime.utc(2018, 10),
    ],
    name: 'Color Editor',
    url: 'https://codepen.io/rainforest80256/pen/WajJax',
    tags: [
      tags['FRONTEND']
    ]
  ),
  new CodepenProject(
    timestamp: [
      new DateTime.utc(2018, 8),
    ],
    name: 'TSA Handbook',
    url: 'https://codepen.io/collection/DJNGZN',
    tags: [
      tags['FRONTEND']
    ]
  )
];

class Project {
  List<DateTime> timestamp;
  String name;
  String description;
  String url;
  List<Tag> tags;

  Project({this.timestamp, this.name, this.description = '', this.url, this.tags = const []});
}

class FrontendProject extends Project {
  String deployUrl;

  FrontendProject({
    List<DateTime> timestamp, 
    String name, 
    String description = '', 
    String url, 
    this.deployUrl, 
    List<Tag> tags = const []
  }) : super(
    timestamp: timestamp, 
    name: name, 
    description: description,
    url: url, 
    tags: tags
  );
}
class CodepenProject extends Project {
  CodepenProject({
    List<DateTime> timestamp, 
    String name, 
    String description = '', 
    String url, 
    List<Tag> tags = const []
  }) : super(
    timestamp: timestamp, 
    name: name, 
    description: description,
    url: url, 
    tags: tags
  );
}

class Tag {
  String name;

  Tag({this.name});
}