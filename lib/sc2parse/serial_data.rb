module SC2Parse
  class SerialData
    CODES = {
      "\x02" => :string,
      "\x04" => :array,
      "\x05" => :hash,
      "\x06" => :small_int,
      "\x07" => :big_int,
      "\x09" => :var_int,
    }

    class MalformedData < Exception; end

    def self.restore(data, offset = 0)
      @@stream = BitStream.new data
      array = []
      @@stream.each { array << read }
      array
    end

    def self.convert_to_int(blizz_int)
      (blizz_int & 1) == 1 ? -(blizz_int >> 1) : (blizz_int >> 1)
    end

    private
    def self.next_type
      byte = @@stream.read_byte
      raise MalformedData, "Unknown type #{byte.inspect}" unless CODES[byte]
      CODES[byte]
    end

    def self.read
      send next_type
    end

    def self.small_int
      convert_to_int @@stream.read_small_int
    end

    def self.big_int
      convert_to_int @@stream.read_big_int
    end

    def self.var_int
      byte = @@stream.read_small_int
      value, shift = (byte & 0x7F), 1
      until byte & 0x80 == 0
        byte = @@stream.read_small_int
        value += (byte & 0x7F) << (7 * shift)
        shift += 1
      end
      convert_to_int value
    end

    def self.string
      @@stream.read_string(small_int)
    end

    def self.array
      @@stream.skip 2 # Arrays have 2 pointless bytes at the start
      array = []
      small_int.times { array << read }
      array
    end

    def self.hash
      hash = {}
      small_int.times { hash[small_int] = read }
      hash
    end
  end
end
