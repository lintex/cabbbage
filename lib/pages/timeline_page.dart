import 'package:cabbbage/components/my_calendar_bar.dart';
import 'package:cabbbage/components/my_card_content.dart';
import 'package:cabbbage/components/my_circle_tool_button.dart';
import 'package:cabbbage/components/my_input_textfield.dart';
import 'package:cabbbage/components/my_timeline_tile.dart';
import 'package:cabbbage/models/database.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:get/get.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // 延时500毫秒等待键盘加载
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // 等待500毫秒listview build，然后滚动到底部
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    Database db = Get.find<Database>();
    TextEditingController controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const MyAppBar(title: '日记'),
      body: Column(
        children: [
          const MyCalendarBar(),
          Expanded(
            child: contentList(),
          ),
          // contentList(),
          // const MyFooter(),

          // 底部输入框
          bottomInput(controller, db),
        ],
      ),

      // persistentFooterAlignment: AlignmentDirectional.center,
      // persistentFooterButtons: [

      // // 选择图片按钮
      // MyCircleToolButton(
      //   icon: Icons.image_outlined,
      //   onPressed: () async {
      //     final pickedImage =
      //         await ImagePicker().pickImage(source: ImageSource.gallery);
      //     if (pickedImage != null) {
      //       // _updateSelectedImage(File(pickedImage.path));
      //       // _saveImagePath(pickedImage.path);
      //       debugPrint('pickedImage:${pickedImage.path}');
      //       db.addNote(pickedImage.path, cabId: 8);
      //       Get.snackbar("success", "图片添加成功！");
      //     }
      //   },
      // ),
      // // 添加todo按钮
      // MyCircleToolButton(
      //   icon: Icons.check_box_outlined,
      //   onPressed: () {
      //     Get.bottomSheet(MyBottomSheet(
      //       title: '添加待办',
      //       text: '',
      //       controller: controller,
      //       onPressed: () {
      //         String content = controller.text.trim();
      //         if (content.isNotEmpty) {
      //           db.addNote(controller.text.trim(), cabId: 0);
      //           controller.clear();
      //           Get.back();
      //           Get.snackbar('success', '待办添加成功！',
      //               duration: const Duration(seconds: 1));
      //         } else {
      //           Get.snackbar('error', '内容为空！',
      //               duration: const Duration(seconds: 1));
      //         }
      //       },
      //     ));
      //   },
      // ),
      // // 剪贴板按钮
      // MyCircleToolButton(
      //   icon: Icons.paste_rounded,
      //   onPressed: () {
      //     FlutterClipboard.paste().then((value) {
      //       if (value.trim() == '') {
      //         Get.snackbar("error", "剪贴板内容为空！");
      //       } else {
      //         db.addNote(value.trim());
      //         Get.snackbar("success", "笔记快捷添加成功！",
      //             duration: const Duration(seconds: 1));
      //       }
      //     });
      //   },
      // ),
      // MyCircleToolButton(
      //     icon: CupertinoIcons.add,
      //     onPressed: () => Get.bottomSheet(
      //           MyBottomSheet(
      //             title: '添加草稿',
      //             text: '',
      //             controller: controller,
      //             onPressed: () {
      //               String content = controller.text.trim();
      //               if (content.isNotEmpty) {
      //                 db.addNote(controller.text.trim(), cabId: 10);
      //                 controller.clear();
      //                 Get.back();
      //                 Get.snackbar('success', '草稿添加成功！',
      //                     duration: const Duration(seconds: 1));
      //               } else {
      //                 Get.snackbar('error', '内容为空！',
      //                     duration: const Duration(seconds: 1));
      //               }
      //             },
      //           ),
      //         )),
      // ],
    );
  }

  GetBuilder<Database> contentList() {
    return GetBuilder<Database>(
        init: Database(),
        builder: (db) => ListView.builder(
              shrinkWrap: true, //这一行不要列表无法显示
              controller: _scrollController,
              // physics:
              //     const NeverScrollableScrollPhysics(), //不要无法滚动
              itemCount: db.allNotes.length,
              itemBuilder: (BuildContext context, int index) {
                final currentNote = db.allNotes[index];
                return GestureDetector(
                    onDoubleTap: () =>
                        Get.toNamed('/editNote', arguments: currentNote),
                    child: MyTimelineTile(MyCardContent(
                      note: currentNote,
                      textCollapsed: false,
                    )
                        // Text(currentNote.text)
                        ));
              },
            ));
  }

  Padding bottomInput(TextEditingController controller, Database db) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 25),
      child: Row(
        children: [
          Expanded(
              // height: 60,
              // width: 300,
              child: MyInputTextField(
            controller: controller,
            focusNode: myFocusNode,
          )),
          MyCircleToolButton(
            icon: Icons.send_rounded,
            onPressed: () {
              String content = controller.text.trim();
              if (content.isNotEmpty) {
                db.addNote(controller.text.trim(), cabId: 10);
                controller.clear();
                scrollDown();
                // Get.back();
                Get.snackbar('success', '草稿添加成功！',
                    duration: const Duration(seconds: 1));
              } else {
                Get.snackbar('error', '内容为空！',
                    duration: const Duration(seconds: 1));
              }
            },
          )
        ],
      ),
    );
  }
}
