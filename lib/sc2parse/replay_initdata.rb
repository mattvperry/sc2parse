module SC2Parse
  module Parsers
    class ReplayInitdata
      def initialize(data)
        parse(BitStream.new(data))
      end

      def parse(stream)
        @player_names = []
        stream.read_small_int.times do
          name_length = stream.read_small_int
          @player_names << stream.read_string(name_length)
          stream.skip 5
        end

        stream.skip 24
        id_length = stream.read_small_int
        @sc_account_id = stream.read_string(id_length)
        stream.skip 684
        @realms, @map_hashs = [], []
        while stream.read_string(4).downcase == 's2ma'
          stream.skip 2
          @realms << stream.read_string(2).downcase
          @map_hashs << stream.read_format(32, 'L!')
        end
      end
    end
  end
end

