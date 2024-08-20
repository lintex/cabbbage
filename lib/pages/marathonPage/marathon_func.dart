// 根据数据库isChosen显示中签状态
String chosenState(int i) {
  switch (i) {
    case 0:
      return '未报名';
    case 1:
      return '已中签';
    case 2:
      return '未中签';
    case 3:
      return '已报名';
    default:
      return '未报名';
  }
}

// 马拉松tile显示时间和起点
String getDateAndLocation(DateTime time, String start) {
  String date = '${time.month}月';
  date += '${time.day}日 ';
  date += '${time.hour}:';
  date += time.minute.toString().padLeft(2, '0');
  return date + start;
}
