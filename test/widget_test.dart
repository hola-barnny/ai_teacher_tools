import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
// Import path_provider
import 'package:ai_teacher_tools/main.dart';
import 'package:ai_teacher_tools/models/student.dart';
import 'dart:io';
// Import the generated mocks

void main() async {
  // Initialize Hive for testing
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  final attendanceBox = await Hive.openBox<Student>('attendance_test'); // Use a test-specific box

  // Mock the PathProvider
  final mockPathProvider = MockPathProvider();

  // Ensure the getApplicationDocumentsDirectory method is mocked
  when(mockPathProvider.getApplicationDocumentsDirectory())
      .thenAnswer((_) async => Directory('/mock/directory'));

  testWidgets('Verify HomeScreen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp(attendanceBox: attendanceBox));

    // Verify AppBar title
    expect(find.text('Attendance Management'), findsOneWidget);

    // Verify the presence of buttons
    expect(find.text('Mark Attendance for Alice'), findsOneWidget);
    expect(find.text('Check Alice\'s Attendance'), findsOneWidget);
  });

  testWidgets('Mark Attendance Button Test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp(attendanceBox: attendanceBox));

    // Tap on the 'Mark Attendance for Alice' button
    await tester.tap(find.text('Mark Attendance for Alice'));
    await tester.pump();

    // Verify a snackbar appears with the expected text
    expect(find.text('Attendance for Alice marked as present!'), findsOneWidget);
  });

  testWidgets('Check Attendance Button Test', (WidgetTester tester) async {
    // Add test data to the Hive box
    attendanceBox.put('student_1', Student(name: 'Alice', isPresent: true));

    // Build the app
    await tester.pumpWidget(MyApp(attendanceBox: attendanceBox));

    // Tap on the 'Check Alice\'s Attendance' button
    await tester.tap(find.text('Check Alice\'s Attendance'));
    await tester.pump();

    // Verify a snackbar appears with the expected attendance data
    expect(find.text('Student: Alice, Present: true'), findsOneWidget);
  });
}

class MockPathProvider {
  getApplicationDocumentsDirectory() {}
}
