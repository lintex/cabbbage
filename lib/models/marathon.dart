import 'package:isar/isar.dart';

part "marathon.g.dart"; // dart run build_runner build

@collection
class Marathon {
  Id id = Isar.autoIncrement;
  late String name;
  DateTime? time;
  String? start;
  String? finish;
  String? hotel;
  String? packet;
  String? bibNumber;
  byte isChosen = 0;
}
