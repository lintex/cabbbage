import 'package:cabbbage/components/my_barchart.dart';
import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_card_content.dart';
import 'package:cabbbage/components/my_circle_tool_button.dart';
import 'package:cabbbage/components/my_circularPercentIndicator.dart';
import 'package:cabbbage/components/my_footer.dart';
import 'package:cabbbage/pages/dashboardPage/my_dashboard_marathon_tile.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_dashboard_tile.dart';
import 'package:cabbbage/components/my_drawer.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:image_picker/image_picker.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Database db = Get.put(Database());
    // 获取马拉松数据，显示还未过期三条记录
    db.fetchMarathons();
    TextEditingController controller = TextEditingController();
    // 读取最后一条note，读取数据存储在db.lastNote，已经是obs
    db.fetchLastNote();
    db.fetchLastTodos();
    // 每日积分柱状图
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
    List<Color> progressColor = [
      Colors.lightGreen.shade600,
      Colors.lightGreen.shade500,
      Colors.lightGreen.shade400
    ];
    List<Color> backgroundColor = [
      Colors.lightGreen.shade300,
      Colors.lightGreen.shade200,
      Colors.lightGreen.shade100
    ];
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
            backgroundColor: colorScheme.surface,
            title: GestureDetector(
              onTap: () => Get.toNamed('/timeline'),
              child: Text(
                Tools.getTitle(),
                style: const TextStyle(
                  fontSize: 18,
                ),
                // ? 避免字体加粗的问题
                strutStyle: const StrutStyle(fontWeight: FontWeight.normal),
              ),
            )),
        drawer: const MyDrawer(),
        // persistentFooterAlignment: AlignmentDirectional.center,
        // persistentFooterButtons: myFooterButtons(controller), // 底部图标工具
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
                  child: MyBarChart(myBarData),
                )),
                // 马拉松倒计时模块
                GestureDetector(
                  onTap: () => Get.toNamed('/marathon'),
                  child: MyDashboardTile(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      // 使用Stack堆叠一个percent指示器
                      child: Stack(
                        children: [
                          // 左边马拉松列表
                          Column(
                              children: db.stillMarathons.map((m) {
                            // 将倒计时天数存入数组
                            if (marathonStillDays.length >= 3) {
                              //? 这个地方在马拉松不足三个时会出错
                              marathonStillDays.clear();
                            }
                            marathonStillDays.add(
                              int.parse(Tools.diffDays(m.time!)),
                            );
                            return MyDashboardMarathonTile(marathon: m);
                          }).toList()),
                          // 右边圆圈百分比指示器
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                children: marathonStillDays
                                    .asMap()
                                    .keys
                                    .map(
                                      (index) => Align(
                                          alignment: Alignment.center,
                                          child: MyCircularPercentIndicator(
                                            value: marathonStillDays[index],
                                            lineWidth: 8,
                                            radius: 28 + 8.5 * index,
                                            progressColor: progressColor[index],
                                            backgroundColor:
                                                backgroundColor[index],
                                            center: Text(
                                                "${marathonStillDays.first}天"),
                                          )),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 显示最后三条未完成待办
                MyDashboardTile(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Stack(children: [
                      db.lastTodos.isEmpty
                          ? const SizedBox(
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("没有需要完成的待办事项！"),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => Get.toNamed('/todo'),
                              child: Column(
                                  children:
                                      // Text('hello'.tr),
                                      db.lastTodos
                                          .map((todo) =>
                                              MyCardContent(note: todo))
                                          .toList()),
                            ),
                      // 右上角新建待办按钮
                      Align(
                        alignment: Alignment.topRight,
                        child: MyCircleToolButton(
                          icon: CupertinoIcons.plus_app,
                          onPressed: () {
                            Get.bottomSheet(MyBottomSheet(
                              title: '添加待办',
                              text: '',
                              controller: controller,
                              onPressed: () {
                                Get.find<Database>()
                                    .addNote(controller.text, cabId: 0);
                                controller.clear();
                                Get.back();
                                Get.snackbar('success', '待办添加成功！',
                                    duration: const Duration(seconds: 2));
                              },
                            ));
                          },
                        ),
                      ),
                      // 右下角显示“待办事项”文字
                      db.lastTodos.length > 1
                          ? const Positioned(
                              right: 10,
                              bottom: 0,
                              child: Text(
                                "待办事项",
                                style: TextStyle(fontFamily: '方正大标宋'),
                              ),
                            )
                          : Container(),
                    ]),
                  ),
                ),
                // note 显示模块
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 178,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: db.lastNotes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: colorScheme.primary),
                        child: Center(
                            child: GestureDetector(
                          onTap: () => Get.toNamed('/note'),
                          child: MyCardContent(note: db.lastNotes[index]),
                        )),
                      );
                    },
                  ),
                ),
                // * 测试新的CarouselView
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: CarouselView(
                      itemExtent: 230,
                      shrinkExtent: 200,
                      backgroundColor: colorScheme.primary,
                      children: List<Widget>.generate(20, (int index) {
                        return Center(child: Text('Item $index'));
                      }),
                    ),
                  ),
                ),
                // 快捷输入模块
                MyDashboardTile(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: myFooterButtons(controller),
                )),
                // 小西三项模块
                const MyDashboardTile(
                    child: Row(
                  children: [
                    Spacer(),
                  ],
                )),
                // 页面底部标语
                const MyFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> myFooterButtons(TextEditingController controller) {
    return [
      // 选择图片按钮
      MyCircleToolButton(
        icon: Icons.image_outlined,
        onPressed: () async {
          final pickedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            debugPrint('pickedImage:${pickedImage.path}');
            Get.find<Database>().addNote(pickedImage.path, cabId: 8);
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
              Get.find<Database>().addNote(controller.text, cabId: 0);
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
              Get.find<Database>().addNote(value.trim()); //去除首尾空格换行
              Get.snackbar("success", "笔记快捷添加成功！");
            }
          });
        },
      ),
      MyCircleToolButton(
        icon: CupertinoIcons.add,
        onPressed: () => Get.toNamed('/newNote'),
      ),
    ];
  }
}
