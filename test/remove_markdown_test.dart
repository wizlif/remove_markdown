import 'package:remove_markdown/remove_markdown.dart';
import 'package:test/test.dart';

import 'cases.dart';

void main() {
  for (final testCase in testCases) {
    test('[${testCase.title}] should remove markdown', () async {
      final resultText = testCase.markdown.removeMarkdown();
      expect(resultText, equals(testCase.expectedResult));
    });
  }
}
