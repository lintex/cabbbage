class Tools {
  static String getDate(DateTime d) {
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "${d.year}年${d.month}月${d.day}日${weekday[d.weekday]}";
  }

  static String getFullDateTime(DateTime d) {
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "${d.year}年${d.month}月${d.day}日${weekday[d.weekday]} ${d.hour}:${d.minute}";
  }

  // 计算两个时间间隔多少天
  static String diffDays(DateTime d) {
    return (DateTime.now().difference(d).abs().inDays).toString();
  }

  //【马拉松助手】计算还有多少小时
  static String diffHours(DateTime d) {
    return (DateTime.now().difference(d).abs().inHours -
            DateTime.now().difference(d).abs().inDays * 24)
        .toString();
  }

  //【马拉松助手】计算还有多少分钟
  static String diffMinutes(DateTime d) {
    return (DateTime.now().difference(d).abs().inMinutes -
            DateTime.now().difference(d).abs().inHours * 60)
        .toString();
  }

  //【马拉松助手】计算还有多少秒
  static String diffSeconds(DateTime d) {
    return (DateTime.now().difference(d).abs().inSeconds -
            DateTime.now().difference(d).abs().inMinutes * 60)
        .toString();
  }

  //* 天气+时间标题
  static String getTitle() {
    DateTime d = DateTime.now();
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "🌤️ ${d.month}月${d.day}日 ${weekday[d.weekday]}";
  }
}
