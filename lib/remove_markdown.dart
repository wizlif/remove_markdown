library remove_markdown;

part 'match.ext.dart';

extension RemoveMarkdown on String {
  /// Removes all markdown tags from [this]
  ///
  /// Strips list leaders when [stripListLeaders] is set to true.
  ///
  /// Uses [listUnicodeChar] as character to insert
  /// instead of stripped list leaders.
  ///
  /// Includes support [GitHub-Flavored Markdown](https://github.github.com/gfm/)
  /// when [gfm] is set to true.
  ///
  /// Replace images with alt-text, if [useImgAltText] is present.
  ///
  /// Url tags to skip during parsing can be set in [htmlTagsToSkip].
  ///
  /// Links can be replaced with urls with [replaceLinksWithURL] set.
  ///
  /// Remove abbreviations when [abbr] is true.
  String removeMarkdown({
    bool stripListLeaders = true,
    String? listUnicodeChar,
    bool gfm = true,
    bool useImgAltText = true,
    bool replaceLinksWithURL = true,
    List<String> htmlTagsToSkip = const [],
    bool abbr = true,
  }) {
    var output = replaceAll(
        RegExp(r'^(-\s*?|\*\s*?|_\s*?){3,}\s*', multiLine: true), '');

    if (stripListLeaders) {
      if (listUnicodeChar != null) {
        output = output.replaceAllMapped(
          RegExp(
            r'^([\s\t]*)([\*\-\+]|\d+\.)\s+',
            multiLine: true,
          ),
          (m) => '$listUnicodeChar ${m.tryGet(1)}',
        );
      } else {
        output = output.replaceAllMapped(
          RegExp(r'^([\s\t]*)([\*\-\+]|\d+\.)\s+', multiLine: true),
          (m) => m.tryGet(1),
        );
      }
    }

    if (gfm) {
      output = output
          // Header
          .replaceAll(RegExp(r'\n={2,}'), '\n')
          // Fenced codeblocks
          .replaceAll(RegExp(r'~{3}.*\n'), '')
          // Strikethrough
          .replaceAll(RegExp('~~'), '');
      // Fenced codeblocks
      // .replaceAll(RegExp(r'`{3}.*\n'), '');
    }

    if (abbr) {
      // Remove abbreviations
      output = output.replaceAll(RegExp(r'/\*\[.*\]:.*\n/'), '');
    }
    output = output
        // Remove HTML tags
        .replaceAll(RegExp('<[^>]*>'), '');

    var htmlReplaceRegex = RegExp('<[^>]*>');
    if (htmlTagsToSkip.isNotEmpty) {
      // Using negative lookahead. Eg. (?!sup|sub) will not match 'sup' and 'sub' tags.
      final joinedHtmlTagsToSkip = '(?!${htmlTagsToSkip.join("|")})';

      // Adding the lookahead literal with the default regex for html. Eg./<(?!sup|sub)[^>]*>/ig
      htmlReplaceRegex = RegExp(
        '<$joinedHtmlTagsToSkip[^>]*>',
        caseSensitive: false,
      );
    }

    return output
        // Remove HTML tags
        .replaceAll(htmlReplaceRegex, '')
        // Remove setext-style headers
        .replaceAll(RegExp(r'^[=\-]{2,}\s*$'), '')
        // Remove footnotes?
        .replaceAll(RegExp(r'\[\^.+?\](\: .*?$)?'), '')
        .replaceAll(RegExp(r'\s{0,2}\[.*?\]: .*?$'), '')
        // Remove images
        .replaceAllMapped(
          RegExp(r'\!\[(.*?)\][\[\(].*?[\]\)]'),
          (m) => useImgAltText ? m.tryGet(1) : '',
        )
        // Remove inline links
        .replaceAllMapped(
          RegExp(r'\[([^\]]*?)\][\[\(](.*?)[\]\)]'),
          (m) => replaceLinksWithURL ? m.tryGet(2) : m.tryGet(1),
        )
        // Remove blockquotes
        .replaceAll(RegExp(r'^\s{0,3}>\s?', multiLine: true), '')
        // .replace(/(^|\n)\s{0,3}>\s?/g, '\n\n')
        // Remove reference-style links?
        .replaceAll(RegExp(r'^\s{1,2}\[(.*?)\]: (\S+)( ".*?")?\s*$'), '')
        // Remove atx-style headers
        .replaceAllMapped(
          RegExp(
            r'^(\n)?\s{0,}#{1,6}\s+| {0,}(\n)?\s{0,}#{0,} #{0,}(\n)?\s{0,}$',
            multiLine: true,
          ),
          (m) => '${m.tryGet(1)}${m.tryGet(2)}${m.tryGet(3)}',
        )
        // Remove * emphasis
        .replaceAllMapped(
          RegExp(r'([\*]+)(\S)(.*?\S)??\1'),
          (m) => '${m.tryGet(2)}${m.tryGet(3)}',
        )
        // Remove _ emphasis. Unlike *, _ emphasis gets rendered only if
        //   1. Either there is a whitespace character before opening _ and after closing _.
        //   2. Or _ is at the start/end of the string.
        .replaceAllMapped(
          RegExp(r'(^|\W)([_]+)(\S)(.*?\S)??\2($|\W)'),
          (m) => '${m.tryGet(1)}${m.tryGet(3)}${m.tryGet(4)}${m.tryGet(5)}',
        )
        // Remove code blocks
        .replaceAllMapped(
          RegExp(r'(`{3,})[a-z]{0,}\s([\S\s]*?)\s?\1', multiLine: true),
          (m) => m.tryGet(2),
        )
        // Remove inline code
        .replaceAllMapped(RegExp('`(.+?)`'), (m) => m.tryGet(1))
        // // Replace two or more newlines with exactly two? Not entirely sure this belongs here...
        // .replace(/\n{2,}/g, '\n\n')
        // // Remove newlines in a paragraph
        // .replace(/(\S+)\n\s*(\S+)/g, '$1 $2')
        // Replace strike through
        .replaceAllMapped(RegExp('~(.*?)~'), (m) => m.tryGet(1));
  }
}
