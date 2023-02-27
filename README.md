# Remove Markdown

This package is based on the idea of [remove-markdown](https://www.npmjs.com/package/remove-markdown) and is an attempt to implement this for dart projects.

## Usage

Import the library

```dart
import 'package:remove_markdown/remove_markdown.dart';
```

## Removing markdown

Remove markdown from a string:

```dart
const markdownString = '**Emphasis**';

// strip markdown off the string
// Result: Emphasis
print(markdownString.removeMarkdown());
```

## Supported markdown

List of currently supported markdown bits

Feature | Supported | Tested
---|---|---
Paragraphs | [x] | [x]
Links | [x] | [x]
Images | [x] | [x]
Lists | [x] | [x]
Code blocks | [x] | [x]
Inline code | [x] | [x]
Emphasis | [x] | [x]
Headers | [x] | [x]
HTML Tags | [x] | [ ]
Tables | [ ] | [ ]

