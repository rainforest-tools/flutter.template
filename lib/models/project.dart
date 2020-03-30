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
    imageUrl: 'assets/images/projects/未來科技展微結構設計成果展示平台.png',
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
    imageUrl: 'assets/images/projects/APCOM 議程網頁.png',
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
    imageUrl: 'assets/images/projects/Palette Manager.png',
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
    description: '整合 BIM(Building Information Modeling) 資訊及工程各階段文檔、數據，並進一步視覺化。',
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
    description: '2019 年暑假時在台大土木電腦輔助工程組暑期實習中給實習生介紹前端框架 Vue 所用簡報及範例。',
    url: 'https://github.com/b04501102/TalkDemo_20190708',
    deployUrl: 'https://talk-demo-20190708.herokuapp.com/#/',
    imageUrl: 'assets/images/projects/Workshop Slides and Examples.png',
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
    description: '嘗試不同的 Carousel 的呈現方式。',
    url: 'https://codepen.io/rainforest80256/pen/xBwPJJ',
    imageUrl: 'assets/images/projects/Cards Carousel.png',
    tags: [
      tags['FRONTEND']
    ]
  ),
  new CodepenProject(
    timestamp: [
      new DateTime.utc(2018, 10),
    ],
    name: 'Color Editor',
    description: '練習 Vue 資料綁定及試做顏色選取、編輯介面。',
    url: 'https://codepen.io/rainforest80256/pen/WajJax',
    imageUrl: 'assets/images/projects/Color Editor.png',
    tags: [
      tags['Vue'],
      tags['FRONTEND']
    ]
  ),
  new CodepenProject(
    timestamp: [
      new DateTime.utc(2018, 8),
    ],
    name: 'TSA Handbook',
    description: '用前端切版技術完成大學系上學術交流活動活動手冊。',
    url: 'https://codepen.io/collection/DJNGZN',
    imageUrl: 'assets/images/projects/TSA Handbook.png',
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
  String imageUrl;
  List<Tag> tags;

  Project({this.timestamp, this.name, this.description = '', this.url, this.imageUrl, this.tags = const []});
}

class FrontendProject extends Project {
  String deployUrl;

  FrontendProject({
    List<DateTime> timestamp, 
    String name, 
    String description = '', 
    String url, 
    String imageUrl,
    this.deployUrl, 
    List<Tag> tags = const []
  }) : super(
    timestamp: timestamp, 
    name: name, 
    description: description,
    url: url, 
    imageUrl: imageUrl,
    tags: tags
  );
}
class CodepenProject extends Project {
  CodepenProject({
    List<DateTime> timestamp, 
    String name, 
    String description = '', 
    String url, 
    String imageUrl,
    List<Tag> tags = const []
  }) : super(
    timestamp: timestamp, 
    name: name, 
    description: description,
    url: url, 
    imageUrl: imageUrl,
    tags: tags
  );
}

class Tag {
  String name;

  Tag({this.name});
}