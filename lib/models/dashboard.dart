class Dashboard {
  //* 天气+时间标题
  static String getTitle() {
    DateTime d = DateTime.now();
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "🌤️ ${d.month}月${d.day}日 ${weekday[d.weekday]}";
  }
}
