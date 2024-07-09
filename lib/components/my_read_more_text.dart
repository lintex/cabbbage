import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class MyReadMoreText extends StatelessWidget {
  const MyReadMoreText(this.text, {super.key, this.trimLines = 5});
  final String text;
  final int trimLines;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: trimLines,
      colorClickableText: Colors.lightGreen.shade800,
      trimCollapsedText: '展开',
      trimExpandedText: '\n收起',
      style: const TextStyle(
          fontSize: 16,
          fontFamily: '霞鹜文楷',
          // color: Colors.black,
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
        // 标题加粗
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
                backgroundColor: Theme.of(context).colorScheme.surfaceTint),
          ),
        ),
      ],
    );
  }
}
