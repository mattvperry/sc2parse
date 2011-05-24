module SC2Parse
  module SerialData
    CODES = {
      "\x02" => :string,
      "\x04" => :array,
      "\x05" => :hash,
      "\x06" => :small_int,
      "\x07" => :big_int,
      "\x09" => :var_int,
    }

    class MalformedData < Exception; end

    class << self
      def restore(data, offset = 0)
        @@stream = BitStream.new data
        read
      end

      def convert_to_int(blizz_int)
        (blizz_int & 1) == 1 ? -(blizz_int >> 1) : (blizz_int >> 1)
      end

      private
      def next_type
        byte = @@stream.read_byte
        raise MalformedData, "Unknown type #{byte.inspect}" unless CODES[byte]
        CODES[byte]
      end

      def read
        send next_type
      end

      def small_int
        convert_to_int @@stream.read_small_int
      end

      def big_int
        convert_to_int @@stream.read_big_int
      end

      def var_int
        byte = @@stream.read_small_int
        value, shift = (byte & 0x7F), 1
        until byte & 0x80 == 0
          byte = @@stream.read_small_int
          value += (byte & 0x7F) << (7 * shift)
          shift += 1
        end
        convert_to_int value
      end

      def string
        @@stream.read_string(small_int)
      end

      def array
        @@stream.skip 2 # Arrays have 2 pointless bytes at the start
        array = []
        small_int.times { array << read }
        array
      end

      def hash
        hash = {}
        small_int.times { hash[small_int] = read }
        hash
      end
    end
  end
end
