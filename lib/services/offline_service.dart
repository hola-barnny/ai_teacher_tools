import 'package:hive/hive.dart';

class OfflineService {
  Future<void> saveAttendanceOffline(String studentId, bool isPresent) async {
    var box = await Hive.openBox('attendance');
    await box.put(studentId, isPresent);
  }

  Future<Map> getOfflineAttendance() async {
    var box = await Hive.openBox('attendance');
    return box.toMap();
  }
}
