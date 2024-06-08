import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/pages/marathonPage/marathon_controller.dart';
import 'package:cabbbage/components/my_textfield.dart';
import 'package:cabbbage/theme/theme.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final MarathonController mc = Get.put(MarathonController());
    final marathonNameController = TextEditingController();
    final marathonLocationController = TextEditingController();
    //添加马拉松举行时间
    DateTime marathonDate = DateTime.now();

    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: blueBg,
      onPressed: () {
        //弹出底部表单
        Get.bottomSheet(
          isScrollControlled: true, //这个是为了调整bottomSheet的高度
          Container(
            //width: double.infinity,
            height: 291, //设置自定义高度
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: marathonNameController,
                  hintText: "马拉松名称",
                  //labelText: "马拉松名称",
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: marathonLocationController,
                  hintText: "比赛地点",
                  //labelText: "比赛地点",
                ),
                const SizedBox(
                  height: 10,
                ),
                // Cupertino的日期选择器
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime, //只显示日期，不显示时间
                    initialDateTime: DateTime.now(), //初始时间
                    maximumYear: DateTime.now().year + 1,
                    minimumYear: DateTime.now().year,
                    minimumDate: DateTime.now()
                        .add(const Duration(days: -10)), //最小数值date
                    maximumDate: DateTime.now().add(const Duration(days: 500)),
                    // 时间选择器发生变化时将选择时间存储到变量
                    onDateTimeChanged: (date) {
                      marathonDate = date;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "返回",
                          style: TextStyle(color: Colors.grey),
                        )),
                    TextButton(
                        onPressed: () {
                          //存储到列表
                          mc.marathonList.add({
                            "name": marathonNameController.text.toString(),
                            "location":
                                marathonLocationController.text.toString(),
                            "date": marathonDate.toString(),
                          });
                          //列表重新排序
                          mc.marathonList.sort(
                            (a, b) => DateTime.parse(a["date"])
                                .compareTo(DateTime.parse(b["date"])),
                          );
                          //存储到数据库
                          debugPrint(mc.marathonList.toString());
                          mc.writeData();

                          //清空表单
                          marathonNameController.clear();
                          marathonLocationController.clear();
                          Get.back();
                        },
                        child: const Text("确定")),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        );
      },
      child: Icon(
        Icons.add,
        color: blue,
        size: 35,
      ),
    );
  }
}
