import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/models/marathon.dart';
import 'package:xiao_note/pages/marathonPage/edit_marathon_page.dart';
import 'package:xiao_note/tools/Tools.dart';
import 'dart:async';

class MarathonDetailPage extends StatefulWidget {
  final Marathon marathon;
  const MarathonDetailPage({super.key, required this.marathon});

  @override
  State<MarathonDetailPage> createState() => _MarathonDetailPageState();
}

class _MarathonDetailPageState extends State<MarathonDetailPage> {
  // 定义一个定时器
  late Timer _timer;
  var stillTime = '00天00小时00分00秒'.obs;

  @override
  void initState() {
    super.initState();
    // 初始化定时器，间隔100毫秒刷新一次，这个地方用second:1时间太长
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      stillTime.value =
          "${Tools.diffDays(widget.marathon.time!)}天${Tools.diffHours(widget.marathon.time!)}小时${Tools.diffMinutes(widget.marathon.time!)}分${Tools.diffSeconds(widget.marathon.time!)}秒";
      // print(stillTime);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Text(
                        "倒计时：$stillTime",
                        style:
                            const TextStyle(fontSize: 25, fontFamily: "方正大标宋"),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "比赛名称",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.marathon.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "比赛时间",
                    style: TextStyle(fontSize: 18),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "比赛起点",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.marathon.start!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "比赛终点",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.marathon.finish!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "领物点",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.marathon.packet ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "住宿酒店",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.marathon.hotel!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )));
  }
}
