import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isPresent;

  Student({required this.name, required this.isPresent});
}
