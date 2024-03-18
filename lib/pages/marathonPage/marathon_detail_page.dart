import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/components/my_button.dart';
import 'package:xiao_note/components/my_textfield.dart';
import 'package:xiao_note/models/marathon.dart';
import 'package:xiao_note/models/marathon_database.dart';
import 'package:xiao_note/pages/marathonPage/edit_marathon_page.dart';
import 'package:xiao_note/tools/Tools.dart';

class MarathonDetailPage extends StatelessWidget {
  final Marathon marathon;
  MarathonDetailPage({super.key, required this.marathon});

  // 使用Get找到主页面使用的Controller
  final MarathonDatabase db = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            marathon.name,
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
                      Get.to(() => EditMarathonPage(marathon: marathon)),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "比赛名称",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    marathon.name,
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
                    Tools.getDate(marathon.time!),
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
                    marathon.start!,
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
                    marathon.finish!,
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
                    marathon.hotel!,
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
                    marathon.packet!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
