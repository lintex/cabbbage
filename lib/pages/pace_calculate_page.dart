import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbage/components/my_app_bar.dart';
import 'package:cabbage/pages/paceCalculatePage/my_pace_calculate_textfield.dart';

class PaceCalculatePage extends StatefulWidget {
  const PaceCalculatePage({super.key});

  @override
  State<PaceCalculatePage> createState() => _PaceCalculatePageState();
}

class _PaceCalculatePageState extends State<PaceCalculatePage> {
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController paceMinuteController = TextEditingController();
  final TextEditingController paceSecondController = TextEditingController();
  final speedController = TextEditingController();
  var distance = 0.0.obs;
  var speed = 0.0.obs;

  everyHourCostTime() {
    for (int i = 1; i < distance.value; i++) {
      print("$i公里用时：${i / speed.value * 60}分");
    }
  }

  void timeToPace() {
    if (distanceController.text != "" && hourController.text != "") {
      distance.value = double.parse(distanceController.text);
      double hours = double.parse(hourController.text);
      double minutes = double.parse(minuteController.text);
      double seconds = double.parse(secondController.text);

      double secondsPerKM =
          (hours * 3600 + minutes * 60 + seconds) / distance.value;
      int paceMinute = secondsPerKM ~/ 60;
      int paceSecond = (secondsPerKM % 60).toInt();

      paceMinuteController.text = paceMinute.toString();
      paceSecondController.text = paceSecond.toString();
      // 时速计算
      speed.value = distance / (hours + minutes / 60 + seconds / 3600);
      speedController.text = speed.value.toStringAsFixed(2);
      everyHourCostTime();
    }
  }

  void paceToTime() {
    if (distanceController.text != "" && paceMinuteController.text != "") {
      distance.value = double.parse(distanceController.text);
      double paceMinute = double.parse(paceMinuteController.text);
      double paceSecond = double.parse(paceSecondController.text);

      double secondsAll = (paceMinute * 60 + paceSecond) * distance.value;
      int hours = secondsAll ~/ 3600;
      int minutes = (secondsAll - hours * 3600) ~/ 60;
      int seconds = (secondsAll - hours * 3600 - minutes * 60).toInt();

      hourController.text = hours.toString();
      minuteController.text = minutes.toString();
      secondController.text = seconds.toString();

      // 时速计算
      speed.value = distance / (hours + minutes / 60 + seconds / 3600);
      speedController.text = speed.value.toStringAsFixed(2);
      everyHourCostTime();
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
    speedController.text = "0";

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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //autofocus: true,
                        textInputAction: TextInputAction.go,
                        style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 4, //字符间距
                            fontFamily: "DigitalNumbers",
                            // 文字阴影
                            shadows: const [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 50, 50, 50),
                              ),
                            ],
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: "跑步距离",
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
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
                          BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer, // 设置边框颜色为蓝色
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
                          BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer, // 设置边框颜色为蓝色
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
                        distanceController.text = "10.00";
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
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
                        distanceController.text = "5.00";
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer, // 设置边框颜色为蓝色
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
                      color: Theme.of(context).colorScheme.primary,
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
                      child: Icon(
                        Icons.arrow_downward_rounded,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        size: 50,
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      onPressed: () => paceToTime(),
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(16),
                      shape: const CircleBorder(),
                      child: Icon(
                        Icons.arrow_upward_rounded,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
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
                      color: Theme.of(context).colorScheme.primary,
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
                      Expanded(
                        child: MyPaceCalculateTextField(
                            text: "时速", controller: speedController),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("每公里用时："),
                SizedBox(
                  height: 15,
                ),
                Text("大众等级成绩："),
              ],
            ),
          ),
        ));
  }
}
