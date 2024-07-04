import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:cabbbage/pages/paceCalculatePage/my_pace_calculate_textfield.dart';

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

  List<List<String>> costTimeList = [
    ['公里', '用时'],
  ].obs;
  var speedLevelText = ''.obs;

  final List speedList = [
    [DateTime(2000, 1, 1, 3, 15), '精英级'], //3小时15分 40岁 精英级
    [DateTime(2000, 1, 1, 3, 45), '大众一级'],
    [DateTime(2000, 1, 1, 4, 15), '大众二级'],
  ];

  countSpeedLevel(int hour, int minute) {
    DateTime mySpeed = DateTime(2000, 1, 1, hour, minute);
    for (List s in speedList) {
      if (mySpeed.isBefore(s[0])) {
        speedLevelText.value = s[1];
        break;
      }
    }
  }

  addCostTime(int paceMinute, int paceSecond) {
    costTimeList.clear();
    costTimeList.add(['公里', '用时', '公里', '用时']);

    for (int i = 1; i <= distance.value ~/ 2; i++) {
      // int hour = i ~/ speed.value;
      // int minute = (i / speed.value * 60 - hour * 60).toInt();
      // int second =
      //     (i / speed.value * 60 * 60 - hour * 60 * 60 - minute * 60).toInt();
      int i2 = distance.value ~/ 2 + i;
      int allSecond = i * (paceMinute * 60 + paceSecond);
      int hour = allSecond ~/ 3600;
      int minute = (allSecond - hour * 3600) ~/ 60;
      int second = (allSecond - minute * 60 - hour * 3600);

      int allSecond2 = i2 * (paceMinute * 60 + paceSecond);
      int hour2 = allSecond2 ~/ 3600;
      int minute2 = (allSecond2 - hour2 * 3600) ~/ 60;
      int second2 = (allSecond2 - minute2 * 60 - hour2 * 3600);

      costTimeList.add([
        i.toString(),
        '${hour == 0 ? "" : "$hour:"}${hour == 0 ? minute : minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}',
        i2.toString(),
        '${hour2 == 0 ? "" : "$hour2:"}${hour2 == 0 ? minute2 : minute2.toString().padLeft(2, '0')}:${second2.toString().padLeft(2, '0')}',
      ]);
      // print("$i公里用时：${i / speed.value * 60}分");
    }
  }

  void timeToPace() {
    if (distanceController.text != "" &&
        (hourController.text != "" || minuteController.text != '')) {
      distance.value = double.parse(distanceController.text);
      // 解决输入框为空的问题
      if (hourController.text == '') {
        hourController.text = '0';
      }
      if (minuteController.text == '') {
        minuteController.text = '0';
      }
      if (secondController.text == '') {
        secondController.text = '0';
      }
      int hours = int.parse(hourController.text);
      int minutes = int.parse(minuteController.text);
      int seconds = int.parse(secondController.text);
      if (minutes > 60) {
        minuteController.text = '59';
        minutes = 59;
        Get.snackbar("error", "分钟不能大于60");
      }
      if (seconds > 60) {
        secondController.text = '59';
        seconds = 59;
        Get.snackbar("error", "秒不能大于60");
      }
      double secondsPerKM =
          (hours * 3600 + minutes * 60 + seconds) / distance.value;
      int paceMinute = secondsPerKM ~/ 60;
      int paceSecond = (secondsPerKM % 60).toInt();

      paceMinuteController.text = paceMinute.toString();
      paceSecondController.text = paceSecond.toString();
      // 时速计算
      speed.value = distance / (hours + minutes / 60 + seconds / 3600);
      speedController.text = speed.value.toStringAsFixed(2);

      addCostTime(paceMinute, paceSecond);
      countSpeedLevel(hours, minutes);
    }
  }

  void paceToTime() {
    if (distanceController.text != "" &&
        (paceMinuteController.text != "" || paceSecondController.text != "")) {
      distance.value = double.parse(distanceController.text);
      if (paceMinuteController.text == '') {
        paceMinuteController.text = '0';
      }
      if (paceSecondController.text == '') {
        paceSecondController.text = '0';
      }
      int paceMinute = int.parse(paceMinuteController.text);
      int paceSecond = int.parse(paceSecondController.text);

      if (paceSecond > 60) {
        paceSecondController.text = '59';
        paceSecond = 59;
        Get.snackbar("error", "配速秒不能大于60");
      }

      if (paceMinute < 2) {
        Get.snackbar("alert", "配速过快！超过人类最快速度...");
      }
      if (paceMinute >= 9) {
        Get.snackbar("alert", "配速过慢！超过马拉松关门时间...");
      }

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

      addCostTime(paceMinute, paceSecond);
      countSpeedLevel(hours, minutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    //一般我们设置默认显示的内容时可以这样
    //_textEditingController.text ="早起的年轻人";
    //这样导致的问题就是设置值后，输入框的光标会显示在文本最前面，用户体验不好，我们期望的是光标保持在文本最后，所以可以这样来设置
    var textStr = "42.195".obs;
    distanceController.value = TextEditingValue(
        text: textStr.value,
        selection: TextSelection.fromPosition(TextPosition(
            offset: textStr.value.length, affinity: TextAffinity.downstream)));
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
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            distanceController.text = "42.195";
                            textStr.value = "42.195";
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                textStr.value == "42.195"
                                    ? Colors.lightGreen.shade200
                                    : Colors.transparent),
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            distanceController.text = "21.0975";
                            textStr.value = "21.0975";
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                textStr.value == "21.0975"
                                    ? Colors.lightGreen.shade200
                                    : Colors.transparent),
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            distanceController.text = "10.00";
                            textStr.value = "10.00";
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                textStr.value == "10.00"
                                    ? Colors.lightGreen.shade200
                                    : Colors.transparent),
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            distanceController.text = "5.00";
                            textStr.value = "5.00";
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                textStr.value == "5.00"
                                    ? Colors.lightGreen.shade200
                                    : Colors.transparent),
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                      ],
                    )),
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
                const SizedBox(
                  height: 25,
                ),
                Obx(() => Text(
                      "大众等级成绩：$speedLevelText",
                      style: const TextStyle(fontFamily: '方正大标宋', fontSize: 20),
                    )),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "每公里用时表",
                  style: TextStyle(fontFamily: '方正大标宋', fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => Table(
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        2: FixedColumnWidth(60),
                      },
                      border: TableBorder.all(
                          color: Colors.lightGreen.shade200,
                          width: 1,
                          borderRadius: BorderRadius.circular(8)),
                      children: costTimeList
                          .map((row) => TableRow(
                                children: row
                                    .map((cell) => TableCell(
                                            child: Center(
                                                child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Text(
                                            cell,
                                          ),
                                        ))))
                                    .toList(),
                              ))
                          .toList(),
                    )),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}


// 不知道怎么把obs变量当作参数传递

// class MyOutlinedButton extends StatelessWidget {
//   const MyOutlinedButton(
//       {super.key, required this.distance, required this.text, required this.controller});
//   final String distance;
//   final String text;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: () {
//         controller.text = distance;
//         textStr.value = distance;
//       },
//       style: ButtonStyle(
//         backgroundColor: MaterialStatePropertyAll(textStr.value == distance
//             ? Colors.lightGreen.shade200
//             : Colors.transparent),
//         side: MaterialStateProperty.all(
//           BorderSide(
//               color: Theme.of(context)
//                   .colorScheme
//                   .onSecondaryContainer, // 设置边框颜色为蓝色
//               width: 1),
//         ),
//         padding: MaterialStateProperty.all(EdgeInsets.zero),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
//       ),
//     );
//   }
// }
