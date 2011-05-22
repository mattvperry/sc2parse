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

    def self.restore(data, offset = 0)
      @@stream = BitStream.new data

      array = []
      @@stream.each { array << read }
      array
    end

    private
    def self.read
      type = CODES[@@stream.read_byte]
      raise Exception, "Malformed Data" unless type
      send "#{type}".to_sym
    end

    def self.small_int
      convert_to_int @@stream.read_small_int
    end

    def self.big_int
      convert_to_int @@stream.read_big_int
    end

    def self.var_int
      # TODO: Implement this...
    end

    def self.string
      size = @@stream.read_small_int
      read_bytes(size).unpack "A#{size}"
    end

    def self.array
      skip 2 # Arrays have 2 pointless bytes at the start
      array = []
      @@stream.read_small_int.times do |i|
        array << read
      end
      array
    end

    def self.hash
      hash = {}
      @@stream.read_small_int.times do |i|
        hash[@@stream.read_small_int] = read
      end
      hash
    end

    def self.convert_to_int(blizz_int)
      (blizz_int & 1) ? -(blizz_int >> 1) : (blizz_int >> 1)
    end
  end
end
