import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var formater = DateFormat('yyyy-MM-dd');

class Global {
  static late SharedPreferences _prefs;
  static int level = 1; // 等级
  static int levelEff = 20; // 等级收益率-乘法(等级*20)
  static int exp = 0; // 经验
  static Object goldHistory = {}; // 挖矿历史
  static int goldYesterday = 0;
  static int goldToday = 0;
  static int goldTotal = 0;
  static int goldDaily = 0;
  static bool isMining = false; // 是否开启自动挖矿
  static bool isMined = false; // 是否自动挖矿时间结束
  static String startMineTime = ''; // 开始自动挖矿时间
  static int remainMineTime = 28800; // 剩余挖矿时间-默认8小时/28800秒

  static int mintTimes = 0; // 已铸造次数
  static int rocketSuccessCount = 1; // 成功获取加速器次数-乘法(默认x1)
  static int rocketEff = 10; // 加速器效率-N*10(第N次成功铸造)
  static int rocketNum = 0; // 拥有加速器数量
  static int boosterNum = 0; // 拥有延时器数量

  static Object signHistory = {}; // 签到历史
  static List<String> weekSignedTimes = []; // 本周已签到日期
  static bool isSignedToday = false; // 今日是否已签到

  static bool isRate = false; // 是否评价
  static bool isShared = false; // 是否分享
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
    initUserInfo();
    initMintInfo();
    initMineInfo();
    updateGold();
    initSignHistory();
    initTaskList();
  }

  // 初始化账号信息
  static initUserInfo() {
    level = _prefs.getInt('level') ?? 1;
    levelEff = level * 20;
    exp = _prefs.getInt('exp') ?? 0;
  }
  // 初始化铸造信息
  static initMintInfo() {
    mintTimes = _prefs.getInt('mintTimes') ?? 0;
    rocketSuccessCount = _prefs.getInt('rocketSuccessCount') ?? 1;
    rocketEff = rocketSuccessCount * 10;
    rocketNum = _prefs.getInt('rocketNum') ?? 0;
    boosterNum = _prefs.getInt('boosterNum') ?? 0;
  }
  // 初始化挖矿信息
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
        isMined = true;
      }
      _prefs.setInt('remainMineTime', remainMineTime);
    }
  }
  // 初始化签到信息
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
  // 初始化成就任务列表
  static initTaskList() {
    isRate = _prefs.getBool('isRate') ?? false;
    isShared = _prefs.getBool('isShared') ?? false;
    isClaimActivePioneer = _prefs.getBool('isClaimActivePioneer') ?? false;
    isClaimGoalAchiever = _prefs.getBool('isClaimGoalAchiever') ?? false;
    isClaimPowerExpert = _prefs.getBool('isClaimPowerExpert') ?? false;
    isClaimGoalMaster = _prefs.getBool('isClaimGoalMaster') ?? false;
    isClaimVitalityChampion = _prefs.getBool('isClaimVitalityChampion') ?? false;
    isClaimPeakAchiever = _prefs.getBool('isClaimPeakAchiever') ?? false;
  }

  // 开始挖矿
  static startMine() {
    int remainMineTime = _prefs.getInt('remainMineTime') ?? 0;
    if (remainMineTime == 0) return;
    isMining = true;
    _prefs.setBool('isMining', true);
    
    DateTime now = DateTime.now();
    startMineTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    _prefs.setString('startMineTime', startMineTime);
  }
  // 结束挖矿
  static endMine() {
    isMining = false;
    isMined = false;
    _prefs.setBool('isMining', false);
    _prefs.setString('startMineTime', '');
  }
  // 减少挖矿时间
  static decreaseMineTime() {
    remainMineTime -= 1;
    _prefs.setInt('remainMineTime', remainMineTime);
  }
  // 增加挖矿时间
  static increaseMineTime(int val) {
    remainMineTime += val;
    _prefs.setInt('remainMineTime', remainMineTime);
  }
  

  // 获得加速器
  static receiveRocket() {
    mintTimes += 1;
    _prefs.setInt('mintTimes', mintTimes);
    rocketNum += 1;
    _prefs.setInt('rocketNum', rocketNum);
    rocketSuccessCount += 1;
    _prefs.setInt('rocketSuccessCount', rocketSuccessCount);
    rocketEff = rocketSuccessCount * 10;
  }
  // 获得延时器
  static receiveBooster() {
    mintTimes += 1;
    _prefs.setInt('mintTimes', mintTimes);
    boosterNum += 1;
    _prefs.setInt('boosterNum', boosterNum);
  }
  // 使用延时器
  static useBooster() {
    if (boosterNum > 0) {
      boosterNum -= 1;
      _prefs.setInt('boosterNum', boosterNum);
      remainMineTime += 60 * 60 * 2;
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
  // 领取评价奖励
  static receiveRateAward() {
    increaseExp(50);
    isRate = true;
    _prefs.setBool('isRate', true);
  }
  // 领取分享奖励
  static receiveShareAward() {
    increaseExp(25);
    isShared = true;
    _prefs.setBool('isShared', true);
  }
  // 领取3次铸造成功成就奖励
  static receiveMineAward_3() {
    increaseExp(200);
    isClaimActivePioneer = true;
    _prefs.setBool('isClaimActivePioneer', true);
  }
  // 领取首次获得NFT成就奖励
  static receiveNFTAward() {
    increaseExp(500);
    isClaimGoalAchiever = true;
    _prefs.setBool('isClaimGoalAchiever', true);
  }
  // 领取5次铸造成功成就奖励
  static receiveMineAward_5() {
    increaseExp(600);
    isClaimPowerExpert = true;
    _prefs.setBool('isClaimPowerExpert', true);
  }
  // 领取10级成就奖励
  static receiveLevelAward_10() {
    increaseExp(1000);
    isClaimGoalMaster = true;
    _prefs.setBool('isClaimGoalMaster', true);
  }
  // 领取20次铸造成功成就奖励
  static receiveMineAward_20() {
    increaseExp(2000);
    isClaimVitalityChampion = true;
    _prefs.setBool('isClaimVitalityChampion', true);
  }
  // 领取50级成就奖励
  static receiveLevelAward_50() {
    increaseExp(1000);
    isClaimPeakAchiever = true;
    _prefs.setBool('isClaimPeakAchiever', true);
  }
}