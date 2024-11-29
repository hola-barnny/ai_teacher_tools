import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> markAttendance(String studentId, bool isPresent) async {
    await _firestore.collection('attendance').add({
      'studentId': studentId,
      'isPresent': isPresent,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: ListView.builder(
        itemCount: 10, // Simulate 10 students
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Student ${index + 1}'),
            trailing: IconButton(
              icon: Icon(Icons.check_circle),
              onPressed: () => markAttendance('student${index + 1}', true),
            ),
          );
        },
      ),
    );
  }
}
