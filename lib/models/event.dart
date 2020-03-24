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
    description: '負責 Coursera 影片剪輯、石化管線資料庫視覺化網站的修改、以及拿災害相關文獻做斷詞及詞頻統計以建立語料庫',
  ),
  new Event(
    timestamp: new DateTime.utc(2016, 09),
    title: '畢業專題遊戲開發',
    description: '負責遊戲中戰鬥機制程式編寫'
  ),
  new Event(
    timestamp: new DateTime.utc(2018, 07),
    title: '衛武資訊研發部門 iOS 軟體工程師',
    description: '負責 iOS 平台的產品開發'
  ),
  new Event(
    timestamp: new DateTime.utc(2019, 09),
    title: '台大土木電腦輔助工程組'
  ),
];