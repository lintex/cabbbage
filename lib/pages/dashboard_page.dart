import 'dart:math';

import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_card_content.dart';
import 'package:cabbbage/components/my_circle_tool_button.dart';
import 'package:cabbbage/pages/dashboardPage/my_dashboard_marathon_tile.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_dashboard_tile.dart';
import 'package:cabbbage/components/my_drawer.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Get.put(Database());
    // 获取马拉松数据，显示还未过期三条记录
    db.fetchMarathons();
    TextEditingController controller = TextEditingController();
    // 读取最后一条note，读取数据存储在db.lastNote，已经是obs
    db.fetchLastNote();
    List myBarData = [
      4.5,
      54.7,
      22.6,
      78.9,
      99.5,
      19.5,
      89.2,
    ];
    // 马拉松倒计时，用于CircularPercentIndicator显示数据
    List<int> marathonStillDays = [];
    return Theme(
      // 这段代码是为了去除persistentFooterButtons顶部一条分割线
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              Tools.getTitle(),
              style: const TextStyle(fontSize: 18),
            )),
        drawer: const MyDrawer(),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          // 选择图片按钮
          MyCircleToolButton(
            icon: Icons.image_outlined,
            onPressed: () async {
              final pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                // _updateSelectedImage(File(pickedImage.path));
                // _saveImagePath(pickedImage.path);
                debugPrint('pickedImage:${pickedImage.path}');
                db.addNote(pickedImage.path, cabId: 8);
                Get.snackbar("success", "图片添加成功！");
              }
            },
          ),
          // 添加todo按钮
          MyCircleToolButton(
            icon: Icons.check_box_outlined,
            onPressed: () {
              Get.bottomSheet(MyBottomSheet(
                title: '添加待办',
                text: '',
                controller: controller,
                onPressed: () {
                  db.addNote(controller.text, cabId: 0);
                  controller.clear();
                  Get.back();
                  Get.snackbar('success', '待办添加成功！',
                      duration: const Duration(seconds: 2));
                },
              ));
            },
          ),
          // 剪贴板按钮
          MyCircleToolButton(
            icon: Icons.paste_rounded,
            onPressed: () {
              FlutterClipboard.paste().then((value) {
                if (value.trim() == '') {
                  Get.snackbar("error", "剪贴板内容为空！");
                } else {
                  db.addNote(value.trim()); //去除首尾空格换行
                  Get.snackbar("success", "笔记快捷添加成功！");
                }
              });
            },
          ),
          MyCircleToolButton(
            icon: CupertinoIcons.add,
            onPressed: () => Get.toNamed('/newNote'),
          ),
        ],
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                MyDashboardTile(
                    child: Container(
                  height: 150,
                  // width: 230,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(8),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround, // 柱状图的对齐方式
                      maxY: 100, //Y轴的最大值
                      gridData: const FlGridData(show: false), // 去除内部网格线
                      borderData: FlBorderData(show: false), // 去除外边框线
                      // 设置四个方向的文字
                      titlesData: const FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: getBottomTitles)),
                      ),
                      //提示框样式
                      barTouchData: BarTouchData(
                          enabled: true,
                          // 改变提示框背景，要用这种奇葩的写法
                          touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (group) =>
                                  Colors.lightGreen.shade100)),

                      // 条形图的数据
                      // map遍历获取List的索引值，只能用List.asMap().keys.map这种奇怪的写法
                      barGroups: myBarData.asMap().keys.map((index) {
                        return BarChartGroupData(x: index, barRods: [
                          BarChartRodData(
                              color: Colors.lightGreen.shade700,
                              toY: myBarData[index],
                              width: 10,
                              backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.lightGreen.shade200))
                        ]);
                      }).toList(),
                    ),
                    swapAnimationDuration: const Duration(microseconds: 500),
                    swapAnimationCurve: Curves.easeInOut,
                  ),
                )),
                // 马拉松倒计时模块
                GestureDetector(
                  onTap: () => Get.toNamed('/marathon'),
                  child: MyDashboardTile(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                      // 使用Stack堆叠一个percent指示器
                      child: Stack(
                        children: [
                          Column(
                              children: db.stillMarathons.map((m) {
                            marathonStillDays.add(
                              int.parse(Tools.diffDays(m.time!)),
                            );
                            return MyDashboardMarathonTile(marathon: m);
                          }).toList()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircularPercentIndicator(
                                      radius: 45.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 8.0,
                                      percent: 1 - marathonStillDays[2] / 100,
                                      center: Text(
                                          "${marathonStillDays.reduce(min)}天"),
                                      progressColor: Colors.lightGreen.shade500,
                                      backgroundColor:
                                          Colors.lightGreen.shade200,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircularPercentIndicator(
                                      radius: 36.5,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 8.0,
                                      percent: 1 - marathonStillDays[1] / 100,
                                      center: Text(
                                          "${marathonStillDays.reduce(min)}天"),
                                      progressColor: Colors.lightGreen.shade600,
                                      backgroundColor:
                                          Colors.lightGreen.shade200,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircularPercentIndicator(
                                      radius: 28.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 8.0,
                                      percent: 1 - marathonStillDays[0] / 100,
                                      center: Text(
                                          "${marathonStillDays.reduce(min)}天"),
                                      progressColor: Colors.lightGreen.shade700,
                                      backgroundColor:
                                          Colors.lightGreen.shade200,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MyDashboardTile(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('hello'.tr),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: db.lastNotes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 241, 240, 231)),
                        child: Center(
                            child: GestureDetector(
                          onTap: () => Get.toNamed('/note'),
                          child: MyCardContent(note: db.lastNotes[index]),
                        )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 12);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        '一',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        '二',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        '三',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        '四',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        '五',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        '六',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        '日',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
