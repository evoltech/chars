require 'set'

module Chars
  class CharSet < SortedSet

    #
    # Creates a new CharSet object with the given _chars_.
    #
    def initialize(*chars)
      super()

      merge_chars = lambda { |element|
        if element.kind_of?(String)
          element.each_byte(&merge_chars)
        elsif element.kind_of?(Integer)
          self << element
        elsif element.kind_of?(Enumerable)
          element.each(&merge_chars)
        end
      }

      merge_chars.call(chars)
    end

    alias include_byte? include?
    alias bytes to_a
    alias each_byte each
    alias select_bytes select
    alias map_bytes map

    #
    # Returns +true+ if the character set includes the specified _char_,
    # returns +false+ otherwise.
    #
    def include_char?(char)
      return false unless char.respond_to?(:each_byte)

      char.each_byte do |b|
        return include?(b)
      end
    end

    #
    # Returns all the characters within the character set as Strings.
    #
    def chars
      map { |b| b.chr }
    end

    #
    # Iterates over every character within the character set, passing
    # each to the given _block_.
    #
    def each_char(&block)
      each { |b| block.call(b.chr) } if block
    end

    #
    # Selects an Array of characters from the character set that match
    # the given _block_.
    #
    def select_chars(&block)
      chars.select(&block)
    end

    #
    # Maps the characters of the character set using the given _block_.
    #
    def map_chars(&block)
      chars.map(&block)
    end

    #
    # Returns a random byte from the character set.
    #
    def random_byte
      self.entries[rand(self.length)]
    end

    #
    # Returns a random char from the character set.
    #
    def random_char
      random_byte.chr
    end

    #
    # Pass a random byte to the specified _block_, _n_ times.
    #
    def each_random_byte(n,&block)
      n.times { block.call(random_byte) }
    end

    #
    # Pass a random character to the specified _block_, _n_ times.
    #
    def each_random_char(n,&block)
      each_random_byte(n) { |b| block.call(b.chr) }
    end

    #
    # Returns an Array of the specified _length_ containing
    # random bytes from the character set. The specified _length_ may
    # be an Integer, Array or a Range of lengths.
    #
    def random_bytes(length)
      if (length.kind_of?(Array) || length.kind_of?(Range))
        return Array.new(length.sort_by { rand }.first) { random_byte }
      else
        return Array.new(length) { random_byte }
      end
    end

    #
    # Returns an Array of the specified _length_ containing
    # random bytes from the character set with no duplicate bytes. 
    # The specified _length_ may be an Integer, Array or a 
    # Range of lengths.
    #
    def random_distinct_bytes(length)
      if (length.kind_of?(Array) || length.kind_of?(Range))
        return self.entries.sort_by { rand }.slice(0...(length.sort_by { rand }.first))
      else
        return self.entries.sort_by { rand }.slice(0...length) 
      end
    end


    #
    # Returns an Array of the specified _length_ containing
    # random characters from the character set. The specified _length_
    # may be an Integer, Array or a Range of lengths.
    #
    def random_chars(length)
      random_bytes(length).map { |b| b.chr }
    end

    #
    # Returns a String of the specified _length_ containing
    # random characters from the character set.
    #
    def random_string(length)
      random_chars(length).join
    end

    #
    # Returns an Array of the specified _length_ containing
    # random UNIQUE characters from the character set. The specified
    # _length_ may be an Integer, Array or a Range of lengths.
    #
    def random_distinct_chars(length)
      random_distinct_bytes(length).map { |b| b.chr }
    end

    #
    # Returns a String of the specified _length_ containing
    # random UNIQUE characters from the character set.
    #
    def random_distinct_string(length)
      random_distinct_chars(length).join
    end


    #
    # Finds sub-strings within the specified _data_ that are part of the
    # character set, using the given _options_.
    #
    # _options_ may contain the following keys:
    # <tt>:length</tt>:: The minimum length of matching sub-strings
    #                    within the _data_. Defaults to 4, if not
    #                    specified.
    # <tt>:offsets</tt>:: Specifies wether to return a Hash of the
    #                     offsets within the _data_ and the matched
    #                     sub-strings. If not specified a simple
    #                     Array will be returned of the matched
    #                     sub-strings.
    #
    def strings_in(data,options={})
      min_length = (options[:length] || 4)

      if options[:offsets]
        found = {}
        found_substring = lambda { |offset,substring|
          found[offset] = substring
        }
      else
        found = []
        found_substring = lambda { |offset,substring|
          found << substring
        }
      end

      return found if data.length < min_length

      index = 0

      while index <= (data.length - min_length)
        if self === data[index...(index + min_length)]
          sub_index = (index + min_length)

          while self.include_char?(data[sub_index..sub_index])
            sub_index += 1
          end

          found_substring.call(index,data[index...sub_index])
          index = sub_index
        else
          index += 1
        end
      end

      return found
    end

    #
    # Creates a new CharSet object containing the both the characters
    # of the character set and the specified _other_set_.
    #
    def |(other_set)
      super(CharSet.new(other_set))
    end

    alias + |

    #
    # Returns +true+ if all of the bytes within the specified _string_
    # are included in the character set, returns +false+ otherwise.
    #
    #   Chars.alpha === "hello"
    #   # => true
    #
    def ===(string)
      return false unless string.respond_to?(:each_byte)

      string.each_byte do |b|
        return false unless include?(b)
      end

      return true
    end

    alias =~ ===

    #
    # Inspects the character set.
    #
    def inspect
      "#<#{self.class.name}: {" + map { |b|
        case b
        when (0x07..0x0d), (0x20..0x7e)
          b.chr.dump
        when 0x00
          # sly hack to make char-sets more friendly
          # to us C programmers
          '"\0"'
        else
          "0x%02x" % b
        end
      }.join(', ') + "}>"
    end

  end
end
