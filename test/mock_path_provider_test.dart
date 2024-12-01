import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart'; // Import the class to be mocked
import 'mock_path_provider.mocks.dart';  // Import the generated mocks
import 'package:mockito/mockito.dart';
import 'dart:io';

// The mock class should be generated by build_runner
// You should NOT define it manually here

void main() {
  late MockPathProvider mockPathProvider;

  setUp(() {
    mockPathProvider = MockPathProvider();  // Initialize the mock object
  });

  test('test path provider', () async {
    // Mock the method to return a directory
    when(mockPathProvider.getApplicationDocumentsDirectory())
        .thenAnswer((_) async => Directory('/mock/path'));

    // Use the mock method
    final directory = await mockPathProvider.getApplicationDocumentsDirectory();

    // Verify the mock method was called and check the result
    expect(directory.path, '/mock/path');  // Ensure it returns the mock path
    
    // Verify that the method was called exactly once
    verify(mockPathProvider.getApplicationDocumentsDirectory()).called(1);
  });
}