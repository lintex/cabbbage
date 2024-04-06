class Tools {
  static String getDate(DateTime d) {
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "${d.year}年${d.month}月${d.day}日${weekday[d.weekday]}";
  }

  static String getFullDateTime(DateTime d) {
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "${d.year}年${d.month}月${d.day}日${weekday[d.weekday]} ${d.hour}:${d.minute}";
  }

  static String diffDays(DateTime d) {
    return (DateTime.now().difference(d).abs().inDays + 1).toString();
  }

  //* 天气+时间标题
  static String getTitle() {
    DateTime d = DateTime.now();
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "🌤️ ${d.month}月${d.day}日 ${weekday[d.weekday]}";
  }
}
