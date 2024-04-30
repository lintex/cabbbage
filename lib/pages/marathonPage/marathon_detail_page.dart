import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbage/models/marathon.dart';
import 'package:cabbage/pages/marathonPage/edit_marathon_page.dart';
import 'package:cabbage/tools/Tools.dart';
import 'dart:async';

class MarathonDetailPage extends StatefulWidget {
  final Marathon marathon;
  const MarathonDetailPage({super.key, required this.marathon});

  @override
  State<MarathonDetailPage> createState() => _MarathonDetailPageState();
}

// 定义一个可观察的类，用来记录倒计时时间
class Countdown {
  Countdown(
      {this.days = '', this.hours = '', this.minutes = '', this.seconds = ''});
  String days;
  String hours;
  String minutes;
  String seconds;
}

class _MarathonDetailPageState extends State<MarathonDetailPage> {
  // 定义一个定时器
  late Timer _timer;
  // 倒计时可观察
  var countdown = Countdown().obs;
  // 倒计时字体样式
  final countdownNumStyle = TextStyle(
    fontSize: 26,
    fontFamily: "DigitalNumbers",
    color: Colors.green.shade900,
  );
  final countdownTextStyle = const TextStyle(
    fontSize: 18,
    fontFamily: "方正大标宋",
  );

  @override
  void initState() {
    super.initState();
    // 初始化定时器，间隔100毫秒刷新一次，这个地方用second:1时间太长
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // 更新自定义类的值
      countdown(Countdown(
          days: Tools.diffDays(widget.marathon.time!),
          hours: Tools.diffHours(widget.marathon.time!),
          minutes: Tools.diffMinutes(widget.marathon.time!),
          seconds: Tools.diffSeconds(widget.marathon.time!)));
      // print(int.parse(countdown.value.hours) < 0);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    // 定时器销毁
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO 这个地方一直返回空
    print(int.tryParse(countdown.value.hours) ?? 0);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.marathon.name,
            style: const TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
          actions: [
            // 【按钮】修改比赛信息
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () =>
                      Get.to(() => EditMarathonPage(marathon: widget.marathon)),
                  icon: const Icon(Icons.edit_calendar_outlined)),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // TODO 这个地方老是报错
              if (10 < 0) ...[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "比赛已经结束！",
                        style: countdownTextStyle,
                      ),
                    ]),
              ] else ...[
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "倒计时:",
                          style: countdownTextStyle,
                        ),
                        Text(
                          countdown.value.days,
                          style: countdownNumStyle,
                        ),
                        Text(
                          "天",
                          style: countdownTextStyle,
                        ),
                        Text(
                          countdown.value.hours,
                          style: countdownNumStyle,
                        ),
                        Text(
                          "时",
                          style: countdownTextStyle,
                        ),
                        Text(
                          countdown.value.minutes,
                          style: countdownNumStyle,
                        ),
                        Text(
                          "分",
                          style: countdownTextStyle,
                        ),
                        Text(
                          countdown.value.seconds,
                          style: countdownNumStyle,
                        ),
                        Text(
                          "秒",
                          style: countdownTextStyle,
                        ),
                      ],
                    )),
              ],
              const SizedBox(
                height: 30,
              ),
              Container(
                //height: 60,
                width: double.infinity,
                //alignment: Alignment.center,
                // margin: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  //border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 10.0,
                    )
                  ],
                  // gradient: const LinearGradient(
                  //   colors: [Colors.red, Colors.orange],
                  // ),
                ),
                //transform: Matrix4.rotationZ(0.02)
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.marathon.start == ''
                              ? '待公布'
                              : widget.marathon.start!,
                          style: const TextStyle(
                              fontSize: 25, fontFamily: '方正大标宋'),
                        ),
                        const Icon(
                          Icons.arrow_right_alt_rounded,
                          size: 50,
                        ),
                        Text(
                          widget.marathon.finish == ''
                              ? '待公布'
                              : widget.marathon.finish!,
                          style: const TextStyle(
                              fontSize: 25, fontFamily: '方正大标宋'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.date_range),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          Tools.getFullDateTime(widget.marathon.time!),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.money),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "A19999",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.business_center),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.marathon.packet == ''
                              ? "待公布"
                              : widget.marathon.packet!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.hotel),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.marathon.hotel == ''
                              ? "待预订"
                              : widget.marathon.hotel!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )));
  }
}
