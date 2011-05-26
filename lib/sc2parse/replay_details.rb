module SC2Parse
  module Parsers
    class ReplayDetails
      FIELDS = {
        players: 0,
        map_name: 1,
        map_tga: 3,
        game_start_time: 5,
        timezone_offset: 6
      }

      def initialize(data)
        @data = SerialData.restore data
      end

      def players
        # parse players seperately
        @data[FIELDS[:players]]
      end

      def map_tga
        @data[FIELDS[:map_tga]][0]
      end

      def method_missing(sym)
        return @data[FIELDS[sym]] if FIELDS.has_key? sym
        super
      end
    end
  end
end
