import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';  // Mockito for mocking
import 'package:ai_teacher_tools/helpers/path_provider_wrapper.dart';  // PathProviderWrapper import

// Mock class for PathProviderWrapper
class MockPathProviderWrapper extends Mock implements PathProviderWrapper {}

void main() {
  late MockPathProviderWrapper mockPathProviderWrapper;

  // Before each test, initialize the mock object
  setUp(() {
    mockPathProviderWrapper = MockPathProviderWrapper();
  });

  group('PathProviderWrapper Tests', () {
    test('getApplicationDocumentsDirectory returns the correct path', () async {
      // Mock the behavior of getApplicationDocumentsDirectory
      when(mockPathProviderWrapper.getApplicationDocumentsDirectory())
          .thenAnswer((_) async => Directory('/mock/documents'));

      // Call the mocked method
      final directory = await mockPathProviderWrapper.getApplicationDocumentsDirectory();

      // Assert that the returned directory path is correct
      expect(directory.path, equals('/mock/documents'));

      // Verify the method was called once
      verify(mockPathProviderWrapper.getApplicationDocumentsDirectory()).called(1);
    });

    test('getApplicationDocumentsDirectory handles exceptions gracefully', () async {
      // Mock the method to throw an exception
      when(mockPathProviderWrapper.getApplicationDocumentsDirectory())
          .thenThrow(FileSystemException('Unable to access directory'));

      // Verify that the exception is thrown
      expect(
        () async => await mockPathProviderWrapper.getApplicationDocumentsDirectory(),
        throwsA(isA<FileSystemException>()),
      );

      // Verify the method was called once
      verify(mockPathProviderWrapper.getApplicationDocumentsDirectory()).called(1);
    });
  });
}
