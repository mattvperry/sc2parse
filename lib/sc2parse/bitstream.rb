module SC2Parse
  class BitStream
    attr_accessor :offset, :size

    def initialize(data, offset = 0)
      @data = data
      @offset = offset
      @size = data.length
    end

    def each
      yield while @offset < @size
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
      skip length
      bytes
    end

    def read_format(num, format)
      read_bytes(num).unpack format
    end

    def read_big_int
      read_byte.unpack 'C'
    end

    def read_small_int
      read_bytes(4).unpack 'L'
    end

    def read_string(length)
      read_bytes(length).unpack "A#{length}"
    end
  end
end
