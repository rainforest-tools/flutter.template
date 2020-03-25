import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Skill {
  IconData icon;
  String skillName;
  String description;

  Skill({IconData icon, String skillName, String description}) {
    this.icon = icon;
    this.skillName = skillName;
    this.description = description;
  }
}

final skills = <Skill>[
  new Skill(
    icon: FontAwesomeIcons.vuejs,
    skillName: 'Vue',
    description: '作為前端入門的框架，自學至今已四年，經手過學校、公司的各種專案。熟悉 Vue 生態系的各種功能：Router, Vuex, Transition, ...'
  ),
  new Skill(
    icon: BrandIcons.react,
    skillName: 'React',
    description: '使用 React Hooks 開發，用它完成過自己接的平台架設的案子。熟悉該生系之 Router, Redux, ...'
  ),
  new Skill(
    icon: BrandIcons.flutter,
    skillName: 'Flutter',
    description: '正式版公開後開始學習至今，此個人網頁便是用來練習 Flutter 的成品，嘗試應用此框架跨越 Android, iOS, Web, ... 平台。'
  ),
  new Skill(
    icon: FontAwesomeIcons.swift,
    skillName: 'Swift',
    description: '在衛武資訊實習時正式用 Swift 進行 iPad App 開發，近期正在看 SwiftUI 的內容。'
  ),
  new Skill(
    icon: FontAwesomeIcons.unity,
    skillName: 'Unity',
    description: '熟悉基本 Unity 介面及相關官方套件操作，目前正在學習 Shader 攥寫及官方 Shader Graph、Cinemachine、Post Processing...'
  )
];