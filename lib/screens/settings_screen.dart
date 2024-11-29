import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String subject = 'Math';
  List<String> subjects = ['Math', 'Science', 'English'];

  void saveSettings() {
    // Save preferences to Firestore or locally
    print('Saved settings for $subject');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: subject,
            items: subjects.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                subject = newValue!;
              });
            },
          ),
          ElevatedButton(onPressed: saveSettings, child: Text('Save')),
        ],
      ),
    );
  }
}

