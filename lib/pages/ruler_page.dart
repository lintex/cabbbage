import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RulerPage extends StatelessWidget {
  const RulerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 下面这段代码用来隐藏顶部信号栏
    // WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // 隐藏后，信号栏是黑色的，晚点要真机测试一下
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //获取屏幕尺寸。单位dp
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // 获取屏幕尺寸
    double screenInches = 6.36;
    // 对角线dp长度除于屏幕尺寸 6.36，可得到每英寸多少 dp，即为刻度间隔
    double dppinch = sqrt(height * height + width * width) / screenInches / 10;
    // 1英寸等于 25.4毫米，除于25.4，可得到每毫米多少 dp
    double dppmm = sqrt(height * height + width * width) / screenInches / 25.4;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Stack(
          children: [
            // 画刻度
            CustomPaint(
              painter: MyCustomPainter(dppinch, dppmm),
              size: Size.infinite,
            ),
            // 旋转 cm 刻度数字
            Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: MyNumCustomPainter(dppinch, dppmm), //将刻度间隔传到自定义画笔组件
                size: Size.infinite, //size 设置为全屏幕
              ),
            ),
            // 旋转 inch 刻度数字
            Transform.rotate(
              angle: pi / 2,
              child: CustomPaint(
                painter: MyNumCustomPainter2(dppinch, dppmm), //将刻度间隔传到自定义画笔组件
                size: Size.infinite, //size 设置为全屏幕
              ),
            ),
            // 显示 cm 两个字母
            Positioned(
              left: 90,
              top: height / 2,
              child: const RotatedBox(
                quarterTurns: 3,
                child: Text("cm",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: "方正大标宋")),
              ),
            ),
            // 显示 inch 字样
            Positioned(
              right: 90,
              top: height / 2,
              child: const RotatedBox(
                quarterTurns: 1,
                child: Text("inch",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: "方正大标宋")),
              ),
            ),
            // 关闭按钮
            Positioned(
              left: width / 2 - 43.5,
              bottom: 60,
              child: MaterialButton(
                elevation: 0,
                onPressed: () => Get.back(),
                color: Colors.grey[200],
                textColor: Colors.grey,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.close,
                  size: 55,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// 在 painter 里面没有办法旋转文字，所以只能把这一部分用Transform.rotate包裹起来
class MyNumCustomPainter extends CustomPainter {
  //接受传过来的两个刻度间隔
  double mmGap;
  double inchGap;
  MyNumCustomPainter(this.inchGap, this.mmGap);

  @override
  void paint(Canvas canvas, Size size) {
    int i = 0;
    while (i * mmGap < size.height) {
      TextPainter numPainter = TextPainter(
          text: TextSpan(
              text: "${i ~/ 10}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              )),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      if (i >= 100) {
        drawNum2(numPainter, i, canvas, size);
      } else {
        drawNum(numPainter, i, canvas, size);
      }
      i = i + 10;
    }
  }

  void drawNum(TextPainter numPainter, int i, Canvas canvas, Size size) {
    numPainter.layout();
    numPainter.paint(canvas, Offset(i * mmGap - 210, size.width - 135));
  }

  void drawNum2(TextPainter numPainter, int i, Canvas canvas, Size size) {
    numPainter.layout();
    numPainter.paint(canvas, Offset(i * mmGap - 214, size.width - 135));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 用来显示 inch 刻度数字
class MyNumCustomPainter2 extends CustomPainter {
  double mmGap;
  double inchGap;
  MyNumCustomPainter2(this.inchGap, this.mmGap);

  @override
  void paint(Canvas canvas, Size size) {
    int i = 0;
    while (i * mmGap < size.height) {
      drawNum(i, canvas, size);
      i = i + 10;
    }
  }

  void drawNum(int i, Canvas canvas, Size size) {
    var numPainter = TextPainter(
      text: TextSpan(
          text: "${i ~/ 10}",
          style: const TextStyle(fontSize: 16, color: Colors.black)),
      textDirection: TextDirection.ltr,
    );
    numPainter.layout();
    numPainter.paint(canvas, Offset(i * inchGap - 210, size.width - 135));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyCustomPainter extends CustomPainter {
  //接受传过来的两个刻度间隔
  double mmGap;
  double inchGap;
  MyCustomPainter(this.inchGap, this.mmGap);

  // 定义三种粗细的画笔，用来画刻度线
  Paint paint1 = Paint()
    ..color = Colors.black
    ..strokeWidth = 1;
  Paint paint2 = Paint()
    ..color = Colors.black
    ..strokeWidth = 2;
  Paint paint3 = Paint()
    ..color = Colors.black
    ..strokeWidth = 3;

  // 重写 paint 方法，通过循环画刻度线
  @override
  void paint(Canvas canvas, Size size) {
    int i = 0;
    while (i * mmGap < size.height) {
      if (i % 10 == 0) {
        canvas.drawLine(Offset(0, size.height - i * mmGap),
            Offset(50, size.height - i * mmGap), paint3);
        canvas.drawLine(Offset(size.width - 50, i * inchGap),
            Offset(size.width, i * inchGap), paint3);
        //drawNum(i, canvas, size);
      } else if (i % 5 == 0) {
        canvas.drawLine(Offset(0, size.height - i * mmGap),
            Offset(40, size.height - i * mmGap), paint2);
        canvas.drawLine(Offset(size.width - 40, i * inchGap),
            Offset(size.width, i * inchGap), paint2);
      } else {
        canvas.drawLine(Offset(0, size.height - i * mmGap),
            Offset(30, size.height - i * mmGap), paint1);
        canvas.drawLine(Offset(size.width - 30, i * inchGap),
            Offset(size.width, i * inchGap), paint1);
      }
      i++;
    }
    //drawText(canvas, size);
  }

  // 标出刻度数字
  // void drawNum(int i, Canvas canvas, Size size) {
  //   var numPainter = TextPainter(
  //       text: TextSpan(
  //           text: "${i ~/ 10}",
  //           style: const TextStyle(fontSize: 16, color: Colors.black)),
  //       textDirection: TextDirection.ltr,
  //       textAlign: TextAlign.left);
  //   numPainter.layout();
  //   numPainter.paint(canvas, Offset(60, size.height - i * mmGap - 10));
  //   numPainter.paint(canvas, Offset(size.width - 65, i * inchGap - 10));
  // }

  // 标出 cm 和 inch 文字
  // void drawText(Canvas canvas, Size size) {
  //   var textPainter = TextPainter(
  //     text: const TextSpan(
  //         text: "cm               inch",
  //         style: TextStyle(fontSize: 30, color: Colors.black)),
  //     textDirection: TextDirection.ltr,
  //   );
  //   textPainter.layout();
  //   textPainter.paint(canvas, Offset(80, size.height / 2));
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
