import 'package:isar/isar.dart';

part "note.g.dart"; // dart run build_runner build

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String text;
  DateTime? createdTime;
  DateTime? lastEditedTime;
  byte cabId = 0; // note分类
}
