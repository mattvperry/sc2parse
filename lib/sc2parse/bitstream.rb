module SC2Parse
  class BitStream
    attr_reader :offset

    def initialize(data, offset = 0)
      @data = data
      @offset = offset
    end

    def each
      yield while @offset < @data.size
    end

    def peek
      @data[@offset]
    end

    def skip(num = 1)
      @offset += num
    end

    def read_byte
      read_bytes 1
    end

    def read_bytes(num)
      bytes = @data[@offset,num]
      skip num
      bytes
    end

    def read_format(num, format)
      read_bytes(num).unpack format
    end

    def read_small_int
      read_format(1, 'C').first
    end

    def read_big_int
      read_format(4, 'L').first
    end

    def read_string(length)
      read_format(length, "A#{length}").first
    end
  end
end
