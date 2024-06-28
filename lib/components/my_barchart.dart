import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatelessWidget {
  const MyBarChart(
    this.myBarData, {
    super.key,
  });
  final List myBarData;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround, // 柱状图的对齐方式
        maxY: 100, //Y轴的最大值
        gridData: const FlGridData(show: false), // 去除内部网格线
        borderData: FlBorderData(show: false), // 去除外边框线
        // 设置四个方向的文字
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        //提示框样式
        barTouchData: BarTouchData(
            enabled: true,
            // 改变提示框背景，要用这种奇葩的写法
            touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (group) =>
                    Theme.of(context).colorScheme.primary)),

        // 条形图的数据
        // map遍历获取List的索引值，只能用List.asMap().keys.map这种奇怪的写法
        barGroups: myBarData.asMap().keys.map((index) {
          return BarChartGroupData(x: index, barRods: [
            BarChartRodData(
                color: Colors.lightGreen.shade600,
                toY: myBarData[index],
                width: 10,
                backDrawRodData: BackgroundBarChartRodData(
                    show: true, toY: 100, color: Colors.lightGreen.shade200))
          ]);
        }).toList(),
      ),
      swapAnimationDuration: const Duration(microseconds: 500),
      swapAnimationCurve: Curves.easeInOut,
    );
  }
}

// 显示底部星期数字
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
