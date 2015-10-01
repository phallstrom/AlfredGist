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

This workflow requires API access to gist.github.com.  This requires a personal access token.
Follow these steps to create and configure this token into the workflow.

1. Go to https://github.com/settings/applications.
1. In the 'Personal access tokens' section, click 'Generate New Token'.
1. Enter in a reasonable token description such as 'Alfred Gist Workflow'.
1. Ensure that the only selected scope is 'gist'.
1. Click 'Generate Token'.
1. Copy the newly generated token to your clipboard.
1. In Alfred, type `gistconfig` and select the 'Your API token' line to set your token.

It should look something like this:
![Setup](https://raw.github.com/phallstrom/AlfredGist/master/screenshots/setup.png)

## Configure

Type `gistconfig` to view the existing configuration or change them. When
changing the token and server the value is taken from the clipboard.  

If you want to share your configuration across multiple machines (ie. via
Dropbox) you can provide a shared configuration directory. This directory must
exist before setting it via the configuration.

## Help

Type `gist help` to view this help. If you need more help
[open an issue](https://github.com/phallstrom/AlfredGist/issues) and I'll see what I can do.

## Usage

### Files

If activated as a file action, the contents of the selected file(s) will be
gisted using whatever public/private setting is currently in effect.

### Clipboard Contents

**Public/private gists:**

* `gist private` - a private gist.
* `gist public` - a public gist.
* `gist p` - a gist using the opposite of your current public configuration value. That is, if by default your gists are private `gist p` will create a public one (and vice versa).

**Anonymous gists:**

Gists will be associated with your account by default.

* `gist a` - an anonymous gist.
* `gist anon` - an anonymous gist.

**All of the following examples can take the public/private or the anonymous parameter (but only one of them) as the first argument.**

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

