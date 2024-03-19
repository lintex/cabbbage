class Tools {
  static String getDate(DateTime d) {
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "${d.year}年${d.month}月${d.day}日${weekday[d.weekday]}";
  }

  static String diffDays(DateTime d) {
    return (DateTime.now().difference(d).abs().inDays + 1).toString();
  }
}
