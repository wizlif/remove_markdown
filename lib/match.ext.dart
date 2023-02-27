part of 'remove_markdown.dart';

extension MatchGetExtension on Match {
  String tryGet(int index) {
    return index < 0 || index > groupCount ? '' : group(index) ?? '';
  }
}
