import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/components/my_textfield.dart';
import 'package:cabbbage/models/marathon.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/Tools.dart';

class EditMarathonPage extends StatelessWidget {
  EditMarathonPage({
    super.key,
  });
  final marathonNameController = TextEditingController();
  final marathonStartController = TextEditingController();
  final marathonFinishController = TextEditingController();
  final marathonHotelController = TextEditingController();
  final marathonPacketController = TextEditingController();
  // 使用Get找到主页面使用的Controller
  final Database db = Get.find();

  @override
  Widget build(BuildContext context) {
    Marathon marathon = Get.arguments;
    //添加马拉松举行时间
    DateTime? initDate = marathon.time;
    var marathonDate = initDate.obs;
    // 初始化textfield内容
    marathonNameController.text = marathon.name;
    marathonStartController.text = marathon.start!;
    marathonFinishController.text = marathon.finish!;
    marathonHotelController.text = marathon.hotel!;
    marathonPacketController.text = marathon.packet ?? "";

    pickTime() {
      // 弹出时间选择窗口
      Get.defaultDialog(
          title: '选择时间',
          titleStyle: const TextStyle(fontSize: 15),
          content: Column(children: [
            Obx(() => Text(Tools.getDate(marathonDate.value!))),
            SizedBox(
              height: 200,
              width: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime, //只显示日期，不显示时间
                initialDateTime: marathonDate.value, //初始时间
                // maximumYear: DateTime.now().year + 1,
                // minimumYear: DateTime.now().year,
                minimumDate:
                    DateTime.now().add(const Duration(days: -10)), //最小数值date
                // maximumDate: DateTime.now().add(const Duration(days: 500)),
                use24hFormat: true, // 是否使用24小时制
                dateOrder: DatePickerDateOrder.dmy, // 日期选择器排序方式 默认年/月/日
                // 时间选择器发生变化时将选择时间存储到变量
                onDateTimeChanged: (date) {
                  marathonDate.value = date;
                },
              ),
            ),
          ]),
          cancel: MyButton(
            text: "取消",
            onPressed: () {
              // 取消时设置为初始时间
              marathonDate.value = initDate;
              Get.back();
            },
            color: Theme.of(context).colorScheme.primary,
          ),
          confirm: MyButton(
            text: "确定",
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.blue,
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "修改比赛信息",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
              )),
          actions: [
            // 右边确认按钮右边要空一点
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    // 将比赛信息存入数据库
                    db.updateMarathon(
                        marathon.id,
                        marathonNameController.text,
                        marathonDate.value!,
                        marathonStartController.text,
                        marathonFinishController.text,
                        marathonHotelController.text,
                        marathonPacketController.text);
                    // 清空文本框并返回
                    marathonNameController.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done, size: 30)),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              MyTextField(
                controller: marathonNameController,
                hintText: "请输入比赛名称",
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  // 点击后弹出时间选择
                  onTap: () => pickTime(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "时间",
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          // 显示选择的时间
                          Obx(() => Text(
                                Tools.getDate(marathonDate.value!),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              )),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: marathonStartController,
                hintText: "请输入比赛起点",
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonFinishController,
                hintText: "请输入比赛终点",
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonHotelController,
                hintText: "请输入住宿酒店名称",
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonPacketController,
                hintText: "请输入领物点",
              ),
            ],
          ),
        )));
  }
}
