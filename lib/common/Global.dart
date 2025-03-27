import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var formater = DateFormat('yyyy-MM-dd');

class Global {
  static late SharedPreferences _prefs;
  static String avator = 'assets/images/avator/default.png';
  static int level = 1; // 等级
  static int levelEff = 20; // 等级收益率-乘法(等级*20)
  static int exp = 0; // 经验
  static int goldBalance = 0; // 余额
  static Object goldHistory = {}; // 挖矿历史
  static int goldYesterday = 0;
  static int goldToday = 0;
  static int goldTotal = 0;
  static int goldDaily = 0;
  static int goldMined = 0; // 通过自动挖矿获得的金币
  static bool isMining = false; // 是否开启自动挖矿
  static bool isMined = false; // 是否自动挖矿时间结束
  static String startMineTime = ''; // 开始自动挖矿时间
  static String endMineTime = ''; // 结束自动挖矿时间
  static int remainMineTime = 28800; // 剩余挖矿时间-默认8小时/28800秒
  static int remainStartMineTime = 0; // 开始自动挖矿时剩余挖矿时间
  static int minedCoins = 0; // 自动挖矿金币收益

  static int mintTimes = 0; // 已铸造次数
  static int rocketSuccessCount = 1; // 成功获取加速器次数-乘法(默认x1)
  static int rocketEff = 10; // 加速器效率-N*10(第N次成功铸造)
  static int rocketNum = 0; // 拥有加速器数量
  static int boosterNum = 0; // 拥有延时器数量
  static List<String> nftList = []; // 拥有的NFT列表

  static int goldSigned = 0; // 通过签到获得的金币
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
    initSignHistory();
    updateGold();
    initTaskList();
  }

  // 初始化账号信息
  static initUserInfo() {
    avator = _prefs.getString('avator') ?? 'assets/images/avator/default.png';
    level = _prefs.getInt('level') ?? 1;
    levelEff = level * 20;
    exp = _prefs.getInt('exp') ?? 0;
    nftList = _prefs.getStringList('nftList') ?? [];
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
    goldMined = _prefs.getInt('goldMined') ?? 0;
    goldBalance = _prefs.getInt('goldBalance') ?? 0;
    isMining = _prefs.getBool('isMining') ?? false;
    remainMineTime = _prefs.getInt('remainMineTime') ?? 28800;
    remainStartMineTime = _prefs.getInt('remainStartMineTime') ?? 0;
    minedCoins = _prefs.getInt('minedCoins') ?? 0;
    if (isMining) {
      DateTime startTime = DateTime.parse(_prefs.getString('startMineTime') ?? '');
      DateTime now = DateTime.now();
      int diffSeconds = startTime.difference(now).inSeconds;
      if (remainStartMineTime + diffSeconds > 0) {
        calcMinedCoins(diffSeconds.abs());
        remainMineTime = remainStartMineTime + diffSeconds;
      } else {
        calcMinedCoins(remainMineTime);
        remainMineTime = 0;
        endMine();
      }
    } else {
      // 挖矿时间零点刷新8h
      String endTime = _prefs.getString('endMineTime') ?? '';
      if (endTime != '') {
        String now = DateFormat('yyyy-MM-dd').format(DateTime.now());
        DateTime zeroTime = DateTime.parse('$now 00:00:00');
        if (DateTime.parse(endTime).isBefore(zeroTime)) {
          remainMineTime = 28800;
        }
      } else {
        remainMineTime = 28800;
      }
    }
    _prefs.setInt('remainMineTime', remainMineTime);
  }
  // 初始化签到信息
  static initSignHistory() {
    goldSigned = _prefs.getInt('goldSigned') ?? 0;
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

  // 设置头像
  static setAvator(value) {
    avator = value;
    _prefs.setString('avator', value);
  }


  // 开始挖矿
  static startMine() {
    int remainMineTime = _prefs.getInt('remainMineTime') ?? 0;
    if (remainMineTime == 0) return;
    _prefs.setInt('remainStartMineTime', remainMineTime);
    isMining = true;
    _prefs.setBool('isMining', true);
    
    DateTime now = DateTime.now();
    startMineTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    _prefs.setString('startMineTime', startMineTime);
  }
  // 结束挖矿
  static endMine() {
    _prefs.setInt('remainStartMineTime', 0);
    goldMined += minedCoins;
    goldBalance += minedCoins;
    _prefs.setInt('goldMined', goldMined);
    _prefs.setInt('goldBalance', goldBalance);
    minedCoins = 0;
    _prefs.setInt('minedCoins', minedCoins);
    isMining = false;
    isMined = false;
    _prefs.setBool('isMining', false);
    _prefs.setString('startMineTime', '');
    DateTime now = DateTime.now();
    endMineTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    _prefs.setString('endMineTime', endMineTime);
    updateGold();
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
  // 计算挖矿收益 - minedTime秒
  static calcMinedCoins(minedTime) {
    // 每分钟金币产出 = (算力 × 基础金币收益) * (1 + 动态加成系数（收获率）)
    // 初始算力=10Gh/s  算力递增： 通过在铸造中心不断提升加速器的效率提升每s的算力
    // 基础金币收益=0.1金币/s
    // 动态加成系数与用户当前的等级数有关
    minedCoins = (minedCoins + rocketEff * 0.1 * (1+(levelEff/100)) * minedTime).toInt();
    _prefs.setInt('minedCoins', minedCoins);
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
  // 获得NFT
  static receiveNFT(nftItem) {
    mintTimes += 1;
    _prefs.setInt('mintTimes', mintTimes);
    nftList.add(nftItem);
    _prefs.setStringList('nftList', nftList);
  }


  // 增加经验
  static increaseExp(int value) {
    exp = (exp + value) % 200;
    level += (exp + value) ~/ 200;
    levelEff = level * 20;
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
    goldBalance += value;
    _prefs.setInt('goldBalance', goldBalance);

    updateGold();
  }
  // 减少金币
  static decreaseGold(int value) {
    goldBalance -= value;
    _prefs.setInt('goldBalance', goldBalance);
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
    int newGoldTotal = 0;
    historyTimes.forEach((String time) {
      newGoldTotal += _prefs.getInt('gold_$time') ?? 0;
    });
    goldTotal = newGoldTotal + goldMined + goldSigned;
  }


  // 签到
  static onSignToday() {
    DateTime now = DateTime.now();
    var today = formater.format(now);
    List<String> historyTimes = _prefs.getStringList('sign_times') ?? [];
    if (!historyTimes.contains(today)) {
      _prefs.setStringList('sign_times', [...historyTimes, today]);

      // 连续7天签到奖励，前5日奖励每日200，第6日300，第7日500金币
      int gold = 200;
      if (weekSignedTimes.length == 5) {
        gold = 300;
      } else if (weekSignedTimes.length == 6) {
        gold = 500;
      }
      goldSigned += gold;
      goldBalance += gold;
      _prefs.setInt('goldSigned', goldSigned);
      _prefs.setInt('goldBalance', goldBalance);
    }
    initSignHistory();
    updateGold();
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


  // 清理数据
  static clear() {
    _prefs.clear();
  }
}