import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/pages/marathonPage/marathon_func.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/models/marathon.dart';
import 'package:cabbbage/tools/Tools.dart';
import 'dart:async';

class MarathonDetailPage extends StatefulWidget {
  const MarathonDetailPage({
    super.key,
    // required this.index
  });
  // final int index;

  @override
  State<MarathonDetailPage> createState() => _MarathonDetailPageState();
}

// 定义一个可观察的类，用来记录倒计时时间
class Countdown {
  Countdown(
      {this.days = '', this.hours = '', this.minutes = '', this.seconds = ''});
  String days, hours, minutes, seconds;
}

bool isExpired(Marathon m) {
  return int.parse(Tools.diffSeconds(m.time!)) < 0 ? true : false;
}

class _MarathonDetailPageState extends State<MarathonDetailPage> {
  // final Database db = Get.find();
  // 定义当前马拉松，页面使用，不会更新
  // late Marathon allMarathons;
  Marathon currentMarathon = Get.arguments;

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
          days: (currentMarathon.time!.difference(DateTime.now()).inDays)
              .toString(),
          hours: Tools.diffHours(currentMarathon.time!),
          minutes: Tools.diffMinutes(currentMarathon.time!),
          seconds: Tools.diffSeconds(currentMarathon.time!)));
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            currentMarathon.name,
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
              padding: const EdgeInsets.only(right: 20),
              child: PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 30,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: "edit",
                      child: Text("修改"),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Text("删除"),
                    ),
                  ];
                },
                onSelected: (Object object) {
                  if (object == 'edit') {
                    Get.toNamed('/editMarathon', arguments: currentMarathon);
                  } else if (object == 'delete') {
                    Get.find<Database>().deleteMarathon(currentMarathon.id);
                    Get.back();
                  }
                },
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide.none,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('距离'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    Tools.getFullDateTime(currentMarathon.time!),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text('还有'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (isExpired(currentMarathon)) ...[
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
                height: 20,
              ),
              Container(
                //height: 60,
                width: double.infinity,
                // alignment: Alignment.center,
                // margin: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                decoration: BoxDecoration(
                  // 未中签背景显示为红色
                  color: currentMarathon.isChosen == 2
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.primaryContainer,
                  //border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      offset: const Offset(2.0, 2.0),
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
                    // 显示起点终点
                    currentMarathon.start != '' &&
                            currentMarathon.start == currentMarathon.finish
                        ? _startIsFinish()
                        : _startIsNotFinish(),
                    const SizedBox(
                      height: 20,
                    ),
                    // 显示参赛号
                    _bibNumberRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    // 显示领物地点和住宿酒店
                    _pocketAndHotelRow(),
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

  Column _startIsFinish() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "起点",
            ),
            SizedBox(
              width: 25,
            ),
            Icon(Icons.cached_rounded),
            SizedBox(
              width: 25,
            ),
            Text(
              "终点",
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          currentMarathon.start.toString(),
          style: const TextStyle(fontSize: 25, fontFamily: '方正大标宋'),
        ),
      ],
    );
  }

  Row _pocketAndHotelRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Icon(Icons.shopping_bag_outlined),
            const SizedBox(
              width: 5,
            ),
            Text(
              currentMarathon.packet == '' ? "待公布" : currentMarathon.packet!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.bed_outlined),
            const SizedBox(
              width: 5,
            ),
            Text(
              currentMarathon.hotel == '' ? "待预订" : currentMarathon.hotel!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Row _bibNumberRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Column(
          children: [Icon(Icons.money), Text('参赛号')],
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          currentMarathon.bibNumber == ''
              ? chosenState(currentMarathon.isChosen)
              : currentMarathon.bibNumber.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 35, fontFamily: '方正大标宋'),
        ),
      ],
    );
  }

  Row _startIsNotFinish() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            const Text(
              "起点",
            ),
            Text(
              currentMarathon.start == '' ? '待公布' : currentMarathon.start!,
              style: const TextStyle(fontSize: 25, fontFamily: '方正大标宋'),
            ),
          ],
        ),
        Image.asset(
          'assets/images/rightArrow.png',
          width: 40,
        ),
        Column(
          children: [
            const Text(
              "终点",
            ),
            Text(
              currentMarathon.finish == '' ? '待公布' : currentMarathon.finish!,
              style: const TextStyle(fontSize: 25, fontFamily: '方正大标宋'),
            ),
          ],
        ),
      ],
    );
  }
}
