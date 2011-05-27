module SC2Parse
  class Replay
    module Details
      FIELDS = {
        0 => :players,
        1 => :map_name,
        3 => :map_tga,
        5 => :start_time,
        6 => :timezone_offset,
      }

      def self.parse(data)
        struct = {}
        SerialData.restore(data).each_pair do |k,v|
          struct[FIELDS[k]] = v if FIELDS[k]
        end
        struct
      end
    end
  end
end
