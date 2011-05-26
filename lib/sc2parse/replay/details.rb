module SC2Parse
  class Replay
    class Details
      FIELDS = {
        0 => :players,
        1 => :map_name.
        3 => :map_tga,
        5 => :start_time,
        6 => :timezone_offset,
        10 => :map_hashs
      }

      def initialize(data)
        @data = prune(SerialData.restore(data))
      end

      def players
      end

      def map_tga
      end

      def method_missing(sym)
      end

      private
      def prune(hash)
        hash.each_pair do |k,v|
          hash[FIELDS[k]] = v if FIELDS[k]
          hash.delete k
        end
      end
    end
  end
end
