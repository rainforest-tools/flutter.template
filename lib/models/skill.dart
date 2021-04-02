import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Skill {
  IconData? icon;
  String name;
  List<String> description;

  Skill({this.icon, required this.name, this.description = const []});
}

final skills = <Skill>[
  new Skill(icon: FontAwesomeIcons.vuejs, name: 'Vue', description: [
    '接觸至今已四年多，經手過學校、公司的各種專案。',
    '熟悉 Vue 生態系的各種功能：Router, Vuex, Transition, ...'
  ]),
  new Skill(icon: FontAwesomeIcons.react, name: 'React', description: [
    '使用 React Hooks 開發，近期使用在外包平台架設的案子。',
    '熟悉該生系之 Router, Redux, ...'
  ]),
  new Skill(name: 'Flutter', description: [
    '正式版公開後開始學習至今，此個人網頁便是用來練習 Flutter 的成品。',
    '目前嘗試應用此框架跨越 Android, iOS, Web, ... 平台。'
  ]),
  new Skill(
      icon: FontAwesomeIcons.swift,
      name: 'Swift',
      description: ['在衛武資訊實習時正式用 Swift 進行 iPad App 開發。', '近期正在看 SwiftUI 的內容。']),
  new Skill(icon: FontAwesomeIcons.unity, name: 'Unity', description: [
    '熟悉基本 Unity 介面及相關官方套件操作。',
    '目前透過 Unity Shader 在實作電腦圖學相關的技術，也會搭配官方 Shader Graph、Post Processing 等套件'
  ])
];
