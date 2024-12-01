// lib/screens/grading_screen.dart

import 'package:flutter/material.dart';
import 'package:ai_teacher_tools/services/grading_service.dart'; // Import the grading service

class GradingScreen extends StatefulWidget {
  const GradingScreen({super.key});

  @override
  _GradingScreenState createState() => _GradingScreenState();
}

class _GradingScreenState extends State<GradingScreen> {
  final GradingService gradingService = GradingService(); // Instantiate GradingService
  String grade = 'Not Graded'; // Default grade message

  // Method to grade an assignment based on studentId
  Future<void> gradeAssignment(String studentId) async {
    var result = await gradingService.gradeAssignment(studentId); // Get grade from service
    setState(() {
      grade = result; // Update grade when the result comes back
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grading')), // App bar with title
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () => gradeAssignment('student123'), // Button to trigger grading
            child: Text('Grade Assignment'),
          ),
          Text('Suggested Grade: $grade'), // Display the suggested grade
        ],
      ),
    );
  }
}
