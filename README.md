# Alfred Workflow - Gist

A workflow for [Alfred](http://www.alfredapp.com/) to create [Gists](https://gist.github.com/) from your clipboard contents or selected files.

![Example 1](https://raw.github.com/phallstrom/AlfredGist/master/screenshots/1.png)
![Example 2](https://raw.github.com/phallstrom/AlfredGist/master/screenshots/2.png)

## Requirements

- Alfred Version 2.
- The Alfred [Powerpack](http://www.alfredapp.com/powerpack/).
- A [GitHub](http://github.com) account.
- [Gist.alfredworkflow](Gist.alfredworkflow?raw=true).

## Setup

This workflow requires API access to gist.github.com.  Type `gistsetup` to
start the script that will request this access.

## Configure

Type `gistconfig` to view the existing configuration or change them.

## Help

Type `gist help` to view this help. If you need more help
[open an issue](https://github.com/phallstrom/AlfredGist/issues) and I'll see what I can do.

## Usage

### Files

If activated as a file action, the contents of the selected file(s) will be gisted using whatever public/private setting is currently in effect.

### Clipboard Contents

**Public/private gists:**

* `gist private` - a private gist.
* `gist public` - a public gist.
* `gist p` - a gist using the opposite of your current public configuration value. That is, if by default your gists are private `gist p` will create a public one (and vice versa).

**All of the following examples can take the public/private parameter as the first argument.**

* `gist rb` - a gist with a filename of "gist.rb" (ie. Ruby syntax).
* `gist .rb` - a gist with a filename of "gist.rb" (ie. Ruby syntax). 
* `gist foo.rb` - a gist with a filename of "foo.rb". 
* `gist ipsum lorem` - a gist with no filename/syntax and a description of "ipsum lorem"
* `gist - ipsum lorem` - a gist with no filename/syntax and a description of "ipsum lorem"
* `gist .rb ipsum lorem` - a gist with a filename of "gist.rb" and a description of "ipsum lorem"
* `gist foo.rb ipsum lorem` - a gist with a filename of "foo.rb" and a description of "ipsum lorem"
* `gist rb ipsum lorem` - a gist with *no filename* and a description of "rb ipsum lorem"
* `gist - foo.rb ipsum lorem` - a gist with *no filename* and a description of "foo.rb ipsum lorem"

**Note the lack of a period or the addition of "-" in the filename argument has when specifying a description.**

## Contributions & Thanks

* JJ Asghar

## License:

(The MIT License)

Copyright (c) 2012 Philip Hallstrom

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

