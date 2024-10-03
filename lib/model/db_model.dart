import 'package:hive/hive.dart';

part 'db_model.g.dart';

@HiveType(typeId: 1)
class Student extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String classs;
  @HiveField(2)
  late String admissionNumber;
  @HiveField(3)
  late String address;
  @HiveField(4)
  late String image;
}
