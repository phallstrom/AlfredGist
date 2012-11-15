# AlfredGist

An extension for [Alfred](http://www.alfredapp.com/) to create [Gists](https://gist.github.com/) from your clipboard contents or selected file.

![Example](https://raw.github.com/phallstrom/AlfredGist/master/example.png)

## Requirements

- A [GitHub](http://github.com) account.
- The Alfred [Powerpack](http://www.alfredapp.com/powerpack/).

## Usage

* `gist setup` - Setup Gist authentication token.
* `gist help` - Get help.
* `gist configure` - View current configuration.
* `gist configure key val` - Change the configuration (using appropriate values for key and value).
* `gist` - a plain gist.


**If activated as a file action, the contents of the file will be gisted using
whatever public/private setting is currently in effect.**

**If used to copy the Clipboard...**

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

