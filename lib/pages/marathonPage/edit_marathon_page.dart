import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/pages/marathonPage/marathon_func.dart';
import 'package:cabbbage/pages/marathonPage/marathon_input_tile.dart';
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
  final marathonBibNumberController = TextEditingController();
  // 使用Get找到主页面使用的Controller
  final Database db = Get.find();

  @override
  Widget build(BuildContext context) {
    Marathon marathon = Get.arguments;
    //添加马拉松举行时间
    DateTime? initDate = marathon.time;
    var marathonDate = initDate.obs;
    var marathonStart = ''.obs;
    var marathonFinish = ''.obs;

    // 初始化textfield内容
    marathonNameController.text = marathon.name;
    marathonStartController.text = marathon.start!;
    marathonStart.value = marathon.start!;
    marathonFinish.value = marathon.finish!;
    marathonFinishController.text = marathon.finish!;
    marathonHotelController.text = marathon.hotel!;
    marathonPacketController.text = marathon.packet ?? "";
    marathonBibNumberController.text = marathon.bibNumber ?? "";

    // 是否中签文字标签
    var isChosen = 0.obs;
    var isChosenText = ''.obs;
    isChosen.value = marathon.isChosen;
    isChosenText.value = chosenState(isChosen.value);

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
                minuteInterval: 30, //设置后分钟只有30和00两个选项
                // maximumYear: DateTime.now().year + 1,
                // minimumYear: DateTime.now().year,
                // minimumDate:
                //     DateTime.now().add(const Duration(days: -10)), //最小数值date
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
            // 右边确认按钮
            _submitButton(marathon, marathonDate, isChosen)
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
              const _10HeightBox(),
              // 比赛时间输入
              MarathonInputTile(
                  title: "时间",
                  trailing: Obx(() => Text(
                        Tools.getDate(marathonDate.value!),
                      )),
                  onPressed: pickTime),
              Divider(
                color: Theme.of(context).colorScheme.primary,
              ),
              const _10HeightBox(),
              Obx(() => MarathonInputTile(
                    title: '比赛起点',
                    trailing: Text(marathonStart.value),
                    onPressed: () {
                      Get.bottomSheet(MyBottomSheet(
                        title: '比赛起点',
                        text: marathonStart.value,
                        controller: marathonStartController,
                        onPressed: () {
                          marathonStart.value = marathonStartController.text;
                          Get.back();
                        },
                      ));
                    },
                  )),

              Obx(() => MarathonInputTile(
                    title: '比赛终点',
                    trailing: Text(marathonFinish.value),
                    onPressed: () {
                      Get.bottomSheet(MyBottomSheet(
                        title: '比赛终点',
                        text: marathonFinishController.text,
                        controller: marathonFinishController,
                        onPressed: () {
                          marathonFinish.value = marathonFinishController.text;
                          Get.back();
                        },
                      ));
                    },
                  )),
              // 是否中签选项框
              _isChosenTile(isChosenText, isChosen, context),
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
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: marathonBibNumberController,
                hintText: "参赛号码",
              ),
            ],
          ),
        )));
  }

  Padding _submitButton(
      Marathon marathon, Rx<DateTime?> marathonDate, RxInt isChosen) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
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
              marathonPacketController.text,
              marathonBibNumberController.text,
              isChosen.value,
            );
            // 清空文本框并返回
            marathonNameController.clear();
            // 直接返回到马拉松列表页面，返回马拉松详情页面数据不更新
            // Todo 这个地方返回的路由有问题
            Get.offAndToNamed('/marathon');
          },
          icon: const Icon(Icons.done, size: 30)),
    );
  }

  // 是否中签选项框
  Padding _isChosenTile(
      RxString isChosenText, RxInt isChosen, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          '是否中签',
          style: TextStyle(fontSize: 16),
        ),
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: "0",
                child: Text('未报名'),
              ),
              const PopupMenuItem<String>(
                value: '3',
                child: Text('已报名'),
              ),
              const PopupMenuItem<String>(
                value: '1',
                child: Text('已中签'),
              ),
              const PopupMenuItem<String>(
                value: '2',
                child: Text('未中签'),
              ),
            ];
          },
          onSelected: (String value) {
            switch (value) {
              case '0':
                isChosen.value = 0;
                isChosenText.value = '未报名';
                break;
              case '1':
                isChosen.value = 1;
                isChosenText.value = '已中签';
                break;
              case '2':
                isChosen.value = 2;
                isChosenText.value = '未中签';
                break;
              case '3':
                isChosen.value = 3;
                isChosenText.value = '已报名';
                break;
            }
          }, // 可以设置一个图标来触发弹出菜单
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide.none,
          ),
          child: Row(
            children: [
              Obx(() => Text(isChosenText.value)),
              const Icon(Icons.unfold_more_rounded),
            ],
          ),
        ),
      ]),
    );
  }
}

class _10HeightBox extends StatelessWidget {
  const _10HeightBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}
