import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ai_teacher_tools/helpers/path_provider_wrapper.dart';  // Correct import

// Mock class for PathProviderWrapper
class MockPathProviderWrapper extends Mock implements PathProviderWrapper {}

void main() {
  late MockPathProviderWrapper mockPathProviderWrapper;

  setUp(() {
    // Initialize the mock object before each test
    mockPathProviderWrapper = MockPathProviderWrapper();
  });

  group('PathProviderWrapper Tests', () {
    test('getApplicationDocumentsDirectory returns the correct path', () async {
      // Mock the behavior of getApplicationDocumentsDirectory
      when(mockPathProviderWrapper.getApplicationDocumentsDirectory())
          .thenAnswer((_) async => Directory('/mock/documents'));

      // Use the mock method
      final directory =
          await mockPathProviderWrapper.getApplicationDocumentsDirectory();

      // Assert that the returned path is correct
      expect(directory.path, equals('/mock/documents'));

      // Verify the method was called once
      verify(mockPathProviderWrapper.getApplicationDocumentsDirectory())
          .called(1);
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
      verify(mockPathProviderWrapper.getApplicationDocumentsDirectory())
          .called(1);
    });
  });
}
