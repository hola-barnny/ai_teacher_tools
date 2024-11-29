import 'dart:convert';
import 'package:http/http.dart' as http;

class AnalyticsService {
  Future<String> predictAtRiskStudents(List<Map<String, dynamic>> data) async {
    final response = await http.post(
      Uri.parse('https://your-ai-api.com/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['result'];
    } else {
      throw Exception('Failed to fetch prediction');
    }
  }
}
