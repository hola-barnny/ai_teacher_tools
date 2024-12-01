import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ai_teacher_tools/models/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter for Student model
  Hive.registerAdapter(StudentAdapter());

  // Open the box for storing attendance data
  var attendanceBox = await Hive.openBox<Student>('attendance');

  runApp(MyApp(attendanceBox: attendanceBox));
}

class MyApp extends StatelessWidget {
  final Box<Student> attendanceBox;

  const MyApp({super.key, required this.attendanceBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-Enhanced Teacher Tools',
      theme: ThemeData(primarySwatch: Colors.deepPurple), // Updated primary color
      home: HomeScreen(attendanceBox: attendanceBox),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Box<Student> attendanceBox;

  const HomeScreen({super.key, required this.attendanceBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Management'),
        backgroundColor: Colors.deepPurple, // Matching the theme color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Create a new student attendance record and store it
                var student = Student(name: 'Alice', isPresent: true);
                attendanceBox.put('student_1', student);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attendance for Alice marked as present!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Mark Attendance for Alice'),
            ),
            const SizedBox(height: 20), // Added spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Retrieve and display Alice's attendance data
                var student = attendanceBox.get('student_1');
                if (student != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Student: ${student.name}, Present: ${student.isPresent}'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No attendance data found for Alice.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Check Alice\'s Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
