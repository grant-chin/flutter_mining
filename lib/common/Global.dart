import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var formater = DateFormat('yyyy-MM-dd');

class Global {
  static late SharedPreferences _prefs;
  static int level = 1; // 等级
  static int exp = 0; // 经验
  static Object goldHistory = {}; // 挖矿历史
  static int goldYesterday = 0;
  static int goldToday = 0;
  static int goldTotal = 0;
  static int goldDaily = 0;
  static bool isMining = false; // 是否开启自动挖矿
  static String startMineTime = ''; // 开始自动挖矿时间
  static int remainMineTime = 28800; // 剩余挖矿时间-默认8小时/28800秒

  static Object signHistory = {}; // 签到历史
  static List<String> weekSignedTimes = []; // 本周已签到日期
  static bool isSignedToday = false; // 今日是否已签到

  static bool isRate = false; // 是否评价
  static bool isShared = false; // 是否分享
  static int mintTimes = 0; // 已铸造次数
  static bool isClaimActivePioneer = false; // 是否已领取铸造先锋奖励
  static bool isClaimGoalAchiever = false; // 是否已领取NFT铸造成功成就
  static bool isClaimPowerExpert = false; // 是否已领取铸造专家成就
  static bool isClaimGoalMaster = false; // 是否已领取铸造专家成就
  static bool isClaimVitalityChampion = false; // 是否已领取铸造冠军成就
  static bool isClaimPeakAchiever = false; // 是否已领取巅峰成就

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    level = _prefs.getInt('level') ?? 1;
    exp = _prefs.getInt('exp') ?? 0;
    
    initMineInfo();
    updateGold();
    initSignHistory();
  }

  // 开始挖矿
  static startMine() {
    isMining = true;
    _prefs.setBool('isMining', true);
    
    DateTime now = DateTime.now();
    startMineTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    _prefs.setString('startMineTime', startMineTime);
  }
  // 结束挖矿
  static endMine() {
    isMining = false;
    _prefs.setBool('isMining', false);
    _prefs.setString('startMineTime', '');
  }
  static decreaseMineTime() {
    remainMineTime -= 1;
    _prefs.setInt('remainMineTime', remainMineTime);
  }
  // 初始化获取挖矿信息
  static initMineInfo() {
    isMining = _prefs.getBool('isMining') ?? false;
    remainMineTime = _prefs.getInt('remainMineTime') ?? 0;
    if (isMining) {
      DateTime startTime = DateTime.parse(_prefs.getString('startMineTime') ?? '');
      DateTime now = DateTime.now();
      int diffSeconds = startTime.difference(now).inSeconds;
      if (remainMineTime + diffSeconds > 0) {
        remainMineTime = remainMineTime + diffSeconds;
      } else {
        remainMineTime = 0;
        isMining = false;
      }
      _prefs.setInt('remainMineTime', remainMineTime);
    }
  }

  // 增加经验
  static increaseExp(int value) {
    exp = (exp + value) % 200;
    level += (exp + value) ~/ 200;
    _prefs.setInt('exp', exp);
    _prefs.setInt('level', level);
  }
  
  // 增加金币
  static increaseGold(int value) {
    DateTime now = DateTime.now();
    var time = formater.format(now);
    List<String> historyTimes = _prefs.getStringList('mine_times') ?? [];
    if (!historyTimes.contains(time)) {
      _prefs.setStringList('mine_times', [...historyTimes, time]);
    }
    int newGold = _prefs.getInt('gold_$time') ?? 0;
    _prefs.setInt('gold_$time', newGold + value);

    updateGold();
  }

  // 更新金币数量
  static updateGold() {
    DateTime now = DateTime.now();
    var yesterday = formater.format(now.subtract(Duration(days: 1)));
    var today = formater.format(now);
    goldYesterday = _prefs.getInt('gold_$yesterday') ?? 0;
    goldToday = _prefs.getInt('gold_$today') ?? 0;
    goldDaily = _prefs.getInt('gold_$today') ?? 0;
    List<String> historyTimes = _prefs.getStringList('mine_times') ?? [];
    int _goldTotal = 0;
    historyTimes.forEach((String time) {
      _goldTotal += _prefs.getInt('gold_$time') ?? 0;
    });
    goldTotal = _goldTotal;
  }

  // 获取签到信息
  static initSignHistory() {
    DateTime now = DateTime.now();
    int curYear = now.year; // 今年
    int curMonth = now.month; // 当月
    int curDay = DateTime.now().day; // 今天
    int weekday = DateTime.now().weekday; // 今天是本周的第几天

    String timeMonday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 1)); // 周一
    String timeTuesday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 2)); // 周二
    String timeWednesday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 3)); // 周三
    String timeThursday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 4)); // 周四
    String timeFriday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 5)); // 周五
    String timeSaturday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 6)); // 周六
    String timeSunday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 7)); // 周日

    weekSignedTimes = [];
    List<String> historyTimes = _prefs.getStringList('sign_times') ?? [];
    if (historyTimes.contains(formater.format(now))) isSignedToday = true;
    if (historyTimes.contains(timeMonday)) weekSignedTimes.add('1');
    if (historyTimes.contains(timeTuesday)) weekSignedTimes.add('2');
    if (historyTimes.contains(timeWednesday)) weekSignedTimes.add('3');
    if (historyTimes.contains(timeThursday)) weekSignedTimes.add('4');
    if (historyTimes.contains(timeFriday)) weekSignedTimes.add('5');
    if (historyTimes.contains(timeSaturday)) weekSignedTimes.add('6');
    if (historyTimes.contains(timeSunday)) weekSignedTimes.add('7');
  }

  // 签到
  static onSignToday() {
    DateTime now = DateTime.now();
    var today = formater.format(now);
    List<String> historyTimes = _prefs.getStringList('sign_times') ?? [];
    if (!historyTimes.contains(today)) {
      _prefs.setStringList('sign_times', [...historyTimes, today]);

      // 连续7天签到奖励，前5日奖励每日200，第6日300，第7日500金币
      // if (weekSignedTimes.length == 5) {}
    }
    initSignHistory();
  }

  // 领取
}