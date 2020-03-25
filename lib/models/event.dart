class Event {
  DateTime timestamp;
  String title;
  String description;

  Event({DateTime timestamp, String title, String description = ''}) {
    this.timestamp = timestamp;
    this.title = title;
    this.description = description;
  }
}

final events = <Event>[
  new Event(
    timestamp: new DateTime.utc(2016, 07),
    title: '台大土木CAE暑期實習',
    description: '負責 Coursera 影片剪輯、石化管線資料庫視覺化網站的修改、以及拿災害相關文獻做斷詞及詞頻統計以建立語料庫。',
  ),
  new Event(
    timestamp: new DateTime.utc(2016, 09),
    title: '畢業專題遊戲開發',
    description: '負責遊戲中戰鬥機制程式編寫。'
  ),
  new Event(
    timestamp: new DateTime.utc(2018, 07),
    title: '衛武資訊研發工程師',
    description: '使用 Swift, Vue.js 做 BIM(Building Information Modeling) 相關產品開發。'
  ),
  new Event(
    timestamp: new DateTime.utc(2019, 09),
    title: '台大土木電腦輔助工程組碩士',
    description: '從事 Machine Learning 於土木領域之相關研究。'
  ),
  new Event(
    timestamp: new DateTime.utc(2019, 10),
    title: 'BIM 管理平台開發',
    description: '使用 React.js 開發網頁端平台，用以整合 BIM(Building Information Modeling) 資訊及工程各階段文檔、數據，並進一步視覺化。'
  ),
];