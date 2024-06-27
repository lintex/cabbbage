import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/components/my_textfield.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/Tools.dart';

class NewMarathonPage extends StatelessWidget {
  NewMarathonPage({super.key});
  final marathonNameController = TextEditingController();
  final marathonStartController = TextEditingController();
  final marathonFinishController = TextEditingController();
  final marathonHotelController = TextEditingController();
  final marathonPacketController = TextEditingController();

  // 使用Get找到主页面使用的Controller
  final Database db = Get.find();

  @override
  Widget build(BuildContext context) {
    //添加马拉松举行时间
    DateTime now = DateTime.now();
    // 构建当天7点的DateTime对象
    DateTime initDate = DateTime(now.year, now.month, now.day, 7, 30);
    var marathonDate = initDate.obs;

    pickTime() {
      Get.defaultDialog(
          title: '选择时间',
          titleStyle: const TextStyle(fontSize: 15),
          content: Column(children: [
            Obx(() => Text(Tools.getDate(marathonDate.value))),
            SizedBox(
              height: 200,
              width: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime, //只显示日期，不显示时间
                initialDateTime: marathonDate.value, //初始时间
                // maximumYear: DateTime.now().year + 1,
                // minimumYear: DateTime.now().year,
                minuteInterval: 30, //设置后分钟只有30和00两个选项
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
              Get.back();
            },
            color: Colors.lightGreen,
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "添加马拉松比赛",
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
                    db.addMarathon(
                        marathonNameController.text,
                        marathonDate.value,
                        marathonStartController.text,
                        marathonFinishController.text,
                        marathonHotelController.text,
                        marathonPacketController.text);
                    // 清空文本框并返回
                    marathonNameController.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done_rounded, size: 30)),
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
                hintText: "比赛名称",
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
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
                          Obx(() => Text(
                                Tools.getDate(marathonDate.value),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              )),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Theme.of(context).colorScheme.inversePrimary,
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
                hintText: "比赛起点",
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonFinishController,
                hintText: "比赛终点",
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonHotelController,
                hintText: "住宿酒店",
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonPacketController,
                hintText: "领物地点",
              ),
            ],
          ),
        )));
  }
}
