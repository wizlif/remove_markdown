import 'package:flutter/material.dart';
import 'package:remove_markdown/remove_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remove Markdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Markdown'),
      ),
      backgroundColor: Colors.grey[300],
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final markdownSample = markdownLists[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    markdownSample.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(markdownSample.markdown),
                  Divider(
                    color: Colors.grey[800],
                  ),
                  SelectableText(markdownSample.markdown.removeMarkdown()),
                ],
              ),
            ),
          );
        },
        itemCount: markdownLists.length,
      ),
    );
  }
}

// Samples
final markdownLists = [
  MarkdownSample(
    title: 'Paragraph',
    markdown: '''
The paragraph starts here
and doesn't end until here.''',
  ),
  MarkdownSample(
    title: 'Headers',
    markdown: '''
An H1 Header
============

An H2 Header
------------

# An H1 Header
## An H2 Header
### An H3 Header
#### An H4 Header

# An H1 #Header #
## Still an H2 Header ####
### An H3 Header''',
  ),
  MarkdownSample(
    title: 'Block quotes',
    markdown: '''
> Of all the things I've lost 
> I miss my mind the most. - Mark Twain''',
  ),
  MarkdownSample(
    title: 'Codeblock',
    markdown: '''
```python
name = 'Scott'
print 'Hi my name is ' + name
```''',
  ),
  MarkdownSample(
    title: 'Inline code',
    markdown: '''
In JavaScript, use `console.log()` to print to the console.''',
  ),
  MarkdownSample(
    title: 'Links',
    markdown: '''
[Stack Abuse](http://stackabuse.com)''',
  ),
  MarkdownSample(
    title: 'Image',
    markdown: '''
![My Alt Text](/path/to/my/pic.jpg "My Optional Title Text")''',
  ),
  MarkdownSample(
    title: 'Emphasis',
    markdown: '''
_This is emphasized text!_

__This is strong text!__

*This is emphasized text!*

**This is strong text!**''',
  ),
  MarkdownSample(
    title: 'Lists',
    markdown: '''
* Item 1
* Item 2
* Item 3

+ Item 1
+ Item 2
+ Item 3

- Item 1
- Item 2
- Item 3

- Item 1
  - Sub-item 1
  - Sub-item 2
- Item 2
  - Sub-item 1
  
1. Item 1
2. Item 2
3. Item 3''',
  ),
];

class MarkdownSample {
  final String title;
  final String markdown;

  MarkdownSample({required this.title, required this.markdown});
}
