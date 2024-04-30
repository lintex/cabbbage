import 'package:flutter/material.dart';
import 'package:cabbage/components/my_app_bar.dart';
import 'package:cabbage/pages/timetablePage/my_timetable_cell.dart';
import 'package:cabbage/pages/timetablePage/my_timetable_column_cell.dart';
import 'package:cabbage/pages/timetablePage/my_timetable_row_cell.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});
  final Color blueText = const Color.fromARGB(255, 79, 170, 189);
  final Color blueBg = const Color.fromARGB(255, 222, 251, 247);
  final Color pinkText = const Color.fromARGB(255, 237, 106, 186);
  final Color pinkBg = const Color.fromARGB(255, 255, 238, 248);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "课程表"),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Table(
              //textBaseline: TextBaseline.alphabetic,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,

              //defaultColumnWidth: const FlexColumnWidth(),
              columnWidths: const {
                0: FixedColumnWidth(40),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
              },
              // border: const TableBorder(
              //   top: BorderSide(color: Colors.red),
              //   left: BorderSide(color: Colors.red),
              //   right: BorderSide(color: Colors.red),
              //   bottom: BorderSide(color: Colors.red),
              //   horizontalInside: BorderSide(color: Colors.red),
              //   verticalInside: BorderSide(color: Colors.green),
              // ),
              border: TableBorder.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                  borderRadius: BorderRadius.circular(6)),
              children: [
                TableRow(
                    // decoration: ShapeDecoration(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30)),
                    //     color: Colors.blue),
                    children: [
                      const TableCell(
                        child: Text(""),
                      ),
                      MyTimetableColumnCell(weekday: 1),
                      MyTimetableColumnCell(weekday: 2),
                      MyTimetableColumnCell(weekday: 3),
                      MyTimetableColumnCell(weekday: 4),
                      MyTimetableColumnCell(weekday: 5),
                    ]),
                TableRow(children: [
                  MyTimetableRowCell(num: 2),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(
                    className: "9班",
                    bgColor: blueBg,
                    textColor: blueText,
                    location: "三楼",
                    teacher: "王静",
                  ),
                ]),
                TableRow(children: [
                  MyTimetableRowCell(num: 3),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(
                    className: "15班",
                    bgColor: blueBg,
                    textColor: blueText,
                    location: "四楼",
                    teacher: "陈长伟",
                  ),
                ]),
                TableRow(children: [
                  MyTimetableRowCell(num: 4),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(
                    className: "18班",
                    bgColor: blueBg,
                    textColor: blueText,
                    location: "五楼",
                    teacher: "熊满",
                  ),
                  MyTimetableCell(
                    className: "2班",
                    bgColor: pinkBg,
                    textColor: pinkText,
                    location: "二楼西一",
                    teacher: "王卉",
                  ),
                ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Theme.of(context).colorScheme.outline),
                    children: [
                      TableCell(child: Text("")),
                      TableCell(child: Text("")),
                      TableCell(child: Text("")),
                      TableCell(
                          child: Text(
                        "午 休",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 12),
                      )),
                      TableCell(child: Text("")),
                      TableCell(child: Text("")),
                    ]),
                TableRow(children: [
                  MyTimetableRowCell(num: 5),
                  MyTimetableCell(
                    className: "7班",
                    bgColor: pinkBg,
                    textColor: pinkText,
                    location: "三楼西2",
                    teacher: "李金玉",
                  ),
                  MyTimetableCell(),
                  MyTimetableCell(
                    className: "6班",
                    bgColor: pinkBg,
                    textColor: pinkText,
                    location: "三楼西1",
                    teacher: "潘晓堂",
                  ),
                  MyTimetableCell(
                    className: "1班",
                    bgColor: pinkBg,
                    textColor: pinkText,
                    location: "一楼",
                    teacher: "宋全林",
                  ),
                  MyTimetableCell(),
                ]),
                TableRow(children: [
                  MyTimetableRowCell(num: 6),
                  MyTimetableCell(
                    className: "5班",
                    bgColor: blueBg,
                    textColor: blueText,
                    location: "二楼东1",
                    teacher: "敖光辉",
                  ),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                ]),
                TableRow(children: [
                  MyTimetableRowCell(num: 7),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                  MyTimetableCell(),
                ]),
              ],
            ),
          )),
    );
  }
}
