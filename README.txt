= Chars

* http://chars.rubyforge.org/
* http://github.com/postmodern/chars/
* Postmodern (postmodern.mod3 at gmail.com)

== DESCRIPTION:

Chars is a Ruby library for working with various character sets,
recognizing text and generating random text from specific character sets.

== FEATURES:

* Provides character sets for:
  * Numeric ('0' - '9')
  * Octal ('0' - '7')
  * Uppercase Hexadecimal ('0' - '9', 'A' - 'F')
  * Lowercase Hexadecimal ('0' - '9', 'a' - 'f')
  * Hexadecimal ('0' - '9', 'a' - 'f', 'A' - 'F')
  * Uppercase Alpha ('A' - 'Z')
  * Lowercase Alpha ('a' - 'z')
  * Alpha ('a' - 'z', 'A' - 'Z')
  * Alpha-numeric ('0' - '9', 'a' - 'z', 'A' - 'Z')
  * Punctuation (' ', '\'', '"', '`', ',', ';', ':', '~', '-', '(', ')',
    '[', ']', '{', '}', '.', '?', '!')
  * Symbols (' ', '\'', '"', '`', ',', ';', ':', '~', '-', '(', ')',
    '[', ']', '{', '}', '.', '?', '!', '@', '#', '$', '%', '^', '&', '*',
    '_', '+', '=', '|', '\\', '<', '>', '/')
  * Space (' ', '\f', '\n', '\r', '\t', '\v')
  * Visible ('0' - '9', 'a' - 'z', 'A' - 'Z', '\'', '"', '`', ',',
    ';', ':', '~', '-', '(', ')', '[', ']', '{', '}', '.', '?', '!', '@',
    '#', '$', '%', '^', '&', '*', '_', '+', '=', '|', '\\', '<', '>', '/',)
  * Printable ('0' - '9', 'a' - 'z', 'A' - 'Z', ' ', '\'', '"', '`', ',',
    ';', ':', '~', '-', '(', ')', '[', ']', '{', '}', '.', '?', '!', '@',
    '#', '$', '%', '^', '&', '*', '_', '+', '=', '|', '\\', '<', '>', '/',
    '\f', '\n', '\r', '\t', '\v')
  * Control ('\x00' - '\x1f', '\x7f')
  * ASCII ('\x00' - '\x7f')
  * All ('\x00' - '\xff')

== EXAMPLES:

* Determine whether a byte belongs to a character set:

    0x41.alpha?
    # => true

* Determine whether a String belongs to a character set:

    "22e1c0".hex?
    # => true

* Find all sub-strings that belong to a character set within a String:

    ls = File.read('/bin/ls')
    Chars.printable.strings_in(ls)
    # => ["/lib64/ld-linux-x86-64.so.2", "KIq/", "5J~!", "%L~!", ...]

* Return a random character from the set of all characters:

    Chars.all.random_char
    # => "\x94"

* Return a random Array of characters from the alpha-numeric character set:

    Chars.alpha_numeric.random_chars(10)
    # => ["Q", "N", "S", "4", "x", "z", "3", "M", "F", "F"]

* Return a random Array of a random length of unique characters from the visible character set:
    Chars.visible.random_distinct_chars(1..10)
    # => ["S", "l", "o", "8", "'", "q"]

* Return a random String from the set of all characters:

    Chars.all.random_string(10)
    # => "\xc2h\xad\xccm7\x1e6J\x13"

* Return a random String with a random length between 5 and 10, from the
  set of space characters:

    Chars.space.random_string(5..10)
    # => "\r\v\n\t\n\f"

== INSTALL:

  $ sudo gem install chars

== LICENSE:

The MIT License

Copyright (c) 2009 Hal Brodigan

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
