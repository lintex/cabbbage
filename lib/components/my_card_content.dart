import 'dart:io';
import 'package:cabbbage/models/note.dart';
import 'package:cabbbage/models/database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class MyCardContent extends StatelessWidget {
  final Note note;
  const MyCardContent({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    switch (note.cabId) {
      case 8:
        // 这个地方图片应该缩小
        return SizedBox(
          width: 150,
          height: 150,
          child: Image.file(
            File(note.text),
            fit: BoxFit.cover,
          ),
        );
      // 0 为未完成待办
      case 0 || 1:
        bool taskCompleted = note.cabId == 1 ? true : false;
        return Row(
          children: [
            Checkbox(
                activeColor: Colors.lightGreen[700],
                value: taskCompleted,
                onChanged: (b) {
                  Get.find<Database>()
                      .changeCabId(note.id, taskCompleted ? 0 : 1);
                }),
            Expanded(
                child: Text(
              note.text,
              style: TextStyle(
                decoration: taskCompleted
                    ? TextDecoration.lineThrough //显示删除线
                    : TextDecoration.none,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        );
      default:
        return ReadMoreText(
          note.text,
          trimMode: TrimMode.Line,
          trimLines: 6,
          colorClickableText: Colors.lightGreen.shade800,
          trimCollapsedText: '\n⌄展开',
          trimExpandedText: '\n⌃收起',
          style: const TextStyle(
              fontSize: 16,
              fontFamily: '霞鹜文楷',
              color: Colors.black,
              overflow: TextOverflow.ellipsis),
          annotations: [
            Annotation(
              regExp: RegExp(r'#[^ \f\n\r\t\v#@]+'), // 匹配#后非空非#非@的字符，一次+
              spanBuilder: ({required String text, TextStyle? textStyle}) =>
                  TextSpan(
                text: text,
                style: textStyle?.copyWith(
                    color: Colors.blue, backgroundColor: Colors.blue.shade100),
              ),
            ),
            Annotation(
              regExp: RegExp(r'@[^ \f\n\r\t\v#@]+'), // 匹配@后非空非#非@的字符，一次+
              spanBuilder: ({required String text, TextStyle? textStyle}) =>
                  TextSpan(
                text: text,
                style: textStyle?.copyWith(color: Colors.green),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.snackbar("title", text,
                        duration: const Duration(seconds: 1));
                  },
              ),
            ),
            Annotation(
              regExp: RegExp(r'\*\*.+?\*\*'), // **粗体**
              spanBuilder: ({required String text, TextStyle? textStyle}) =>
                  TextSpan(
                text: text.replaceAll("*", ""),
                style: textStyle?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Annotation(
              regExp: RegExp(r'`.+?`'), // `背景色`
              spanBuilder: ({required String text, TextStyle? textStyle}) =>
                  TextSpan(
                text: text.replaceAll("`", ""),
                style: textStyle?.copyWith(
                    backgroundColor: Colors.yellow.shade300),
              ),
            ),
          ],
        );
    }
  }
}
