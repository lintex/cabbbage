import 'package:flutter/material.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/pages/paceCalculatePage/my_pace_calculate_textfield.dart';
import 'package:xiao_note/theme/theme.dart';
//import 'package:get/get.dart';

class PaceCalculatePage extends StatefulWidget {
  const PaceCalculatePage({super.key});

  @override
  State<PaceCalculatePage> createState() => _PaceCalculatePageState();
}

class _PaceCalculatePageState extends State<PaceCalculatePage> {
  // String _distanceErrorText = '';
  // String _hourErrorText = '';
  // String _minuteErrorText = '';
  // String _secondErrorText = '';
  // String _paceMinuteErrorText = '';
  // String _paceSecondErrorText = '';
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController paceMinuteController = TextEditingController();
  final TextEditingController paceSecondController = TextEditingController();

  void timeToPace() {
    if (distanceController.text != "" && hourController.text != "") {
      double distance = double.parse(distanceController.text);
      double hour = double.parse(hourController.text);
      double minute = double.parse(minuteController.text);
      double second = double.parse(secondController.text);

      double secondsPerKM = (hour * 3600 + minute * 60 + second) / distance;
      int paceMinute = secondsPerKM ~/ 60;
      int paceSecond = (secondsPerKM % 60).toInt();

      paceMinuteController.text = paceMinute.toString();
      paceSecondController.text = paceSecond.toString();

      //double speed = distance / (hour + minute / 60 + second / 3600);

      // Get.defaultDialog(
      //   title: "计算结果",
      //   titleStyle: const TextStyle(fontSize: 20),
      //   middleText:
      //       "距离：${distance.toString()}公里\n用时：${hour.toInt().toString()}小时${minute == 0 ? "" : "${minute.toInt().toString()}分"}${second == 0 ? "" : "${second.toInt().toString()}秒"}\n配速：${paceMinute.toString()}分${paceSecond.toString()}秒/公里\n时速：${speed.toStringAsFixed(2)}公里/小时",
      //   middleTextStyle: const TextStyle(fontSize: 18),
      //   contentPadding: const EdgeInsets.all(20),
      // );
    }
  }

  void paceToTime() {
    if (distanceController.text != "" && paceMinuteController.text != "") {
      double distance = double.parse(distanceController.text);
      double paceMinute = double.parse(paceMinuteController.text);
      double paceSecond = double.parse(paceSecondController.text);

      double secondsAll = (paceMinute * 60 + paceSecond) * distance;
      int hours = secondsAll ~/ 3600;
      int minutes = (secondsAll - hours * 3600) ~/ 60;
      int seconds = (secondsAll - hours * 3600 - minutes * 60).toInt();

      hourController.text = hours.toString();
      minuteController.text = minutes.toString();
      secondController.text = seconds.toString();

      // Get.defaultDialog(
      //   title: "计算结果",
      //   titleStyle: const TextStyle(fontSize: 20),
      //   middleText:
      //       "距离：${distance.toString()}公里\n配速：${paceMinuteController.text}分${paceSecondController.text}秒\n用时：${hours.toString()}小时${minutes.toString()}分${seconds.toString()}秒",
      //   middleTextStyle: const TextStyle(fontSize: 18),
      //   contentPadding: const EdgeInsets.all(20),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    //一般我们设置默认显示的内容时可以这样
    //_textEditingController.text ="早起的年轻人";
    //这样导致的问题就是设置值后，输入框的光标会显示在文本最前面，用户体验不好，我们期望的是光标保持在文本最后，所以可以这样来设置
    String textStr = "42.195";
    distanceController.value = TextEditingValue(
        text: textStr,
        selection: TextSelection.fromPosition(TextPosition(
            offset: textStr.length, affinity: TextAffinity.downstream)));
    hourController.text = "0";
    minuteController.text = "0";
    secondController.text = "0";
    paceMinuteController.text = "0";
    paceSecondController.text = "0";

    return Scaffold(
        appBar: const MyAppBar(title: "马拉松配速计算器"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(
                    width: 5,
                  ),
                  //Row 不允许直接嵌套 TextField，外面要包裹Expanded
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: distanceController,
                        keyboardType: TextInputType.number,
                        //autofocus: true,
                        textInputAction: TextInputAction.go,
                        style:
                            TextStyle(fontSize: 25, color: Colors.green[900]),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: "请输入跑步的距离",
                          labelStyle: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        distanceController.text = "42.195";
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                              color: Colors.green, // 设置边框颜色为蓝色
                              width: 1),
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "全马",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        distanceController.text = "21.0975";
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                              color: Colors.green, // 设置边框颜色为蓝色
                              width: 1),
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "半马",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        distanceController.text = "10";
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                              color: Colors.green, // 设置边框颜色为蓝色
                              width: 1),
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "十公里",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        distanceController.text = "5";
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                              color: Colors.green, // 设置边框颜色为蓝色
                              width: 1),
                        ),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "五公里",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                          child: MyPaceCalculateTextField(
                              text: "小时", controller: hourController)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: MyPaceCalculateTextField(
                              text: "分钟", controller: minuteController)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: MyPaceCalculateTextField(
                              text: "秒", controller: secondController)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      elevation: 0,
                      onPressed: () => timeToPace(),
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(16),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      onPressed: () => paceToTime(),
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(16),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                          child: MyPaceCalculateTextField(
                              text: "分", controller: paceMinuteController)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyPaceCalculateTextField(
                            text: "秒", controller: paceSecondController),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
