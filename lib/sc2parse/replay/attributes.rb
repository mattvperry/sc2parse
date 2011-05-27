module SC2Parse
  class Replay
    module Attributes
      def self.parse(data)
        stream = BitStream.new data
        attributes = []
        stream.skip 5 # null start
        stream.read_big_int.times do
          stream.skip 4 # attr header is always the same
          attribute = {}
          attribute[:id] = stream.read_string(4).reverse
          attribute[:player_number] = stream.read_small_int
          attribute[:value] = stream.read_string(4).reverse
          attributes << attribute
        end
        attributes
      end
    end
  end
end
