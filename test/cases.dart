/// Markdown test cases
class MarkdownTestsCases {
  final String title;
  final String markdown;
  final String expectedResult;

  const MarkdownTestsCases({
    required this.title,
    required this.markdown,
    required this.expectedResult,
  });
}

const testCases = [
  MarkdownTestsCases(
    title: 'Paragraph',
    markdown: '''
The paragraph starts here
and doesn't end until here.''',
    expectedResult: '''
The paragraph starts here
and doesn't end until here.''',
  ),
  MarkdownTestsCases(
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
    expectedResult: '''
An H1 Header


An H2 Header
An H1 Header
An H2 Header
An H3 Header
An H4 Header

An H1 #Header
Still an H2 Header
An H3 Header''',
  ),
  MarkdownTestsCases(
    title: 'Block quotes',
    markdown: '''
> Of all the things I've lost 
> I miss my mind the most. - Mark Twain''',
    expectedResult: '''
Of all the things I've lost
I miss my mind the most. - Mark Twain''',
  ),
  MarkdownTestsCases(
    title: 'Codeblock',
    markdown: '''
```python
name = 'Scott'
print 'Hi my name is ' + name
```''',
    expectedResult: '''
name = 'Scott'
print 'Hi my name is ' + name''',
  ),
  MarkdownTestsCases(
    title: 'Inline code',
    markdown: '''
In JavaScript, use `console.log()` to print to the console.''',
    expectedResult: '''
In JavaScript, use console.log() to print to the console.''',
  ),
  MarkdownTestsCases(
    title: 'Links',
    markdown: '''
[Stack Abuse](http://stackabuse.com)''',
    expectedResult: '''
http://stackabuse.com''',
  ),
  MarkdownTestsCases(
    title: 'Image',
    markdown: '''
![My Alt Text](/path/to/my/pic.jpg "My Optional Title Text")''',
    expectedResult: '''
My Alt Text''',
  ),
  MarkdownTestsCases(
    title: 'Emphasis',
    markdown: '''
_This is emphasized text!_

__This is strong text!__

*This is emphasized text!*

**This is strong text!**''',
    expectedResult: '''
This is emphasized text!

This is strong text!

This is emphasized text!

This is strong text!''',
  ),
  MarkdownTestsCases(
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
    expectedResult: '''
Item 1
Item 2
Item 3

Item 1
Item 2
Item 3

Item 1
Item 2
Item 3

Item 1
  Sub-item 1
  Sub-item 2
Item 2
  Sub-item 1

Item 1
Item 2
Item 3''',
  ),
];
