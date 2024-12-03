import 'dart:io';
import 'package:path_provider/path_provider.dart';  // Correct import

class PathProviderWrapper {
  // This method fetches the application's documents directory
  Future<Directory> getApplicationDocumentsDirectory() async {
    // Correct use of PathProvider to fetch application directory
    return await PathProvider.getApplicationDocumentsDirectory();
  }
}
