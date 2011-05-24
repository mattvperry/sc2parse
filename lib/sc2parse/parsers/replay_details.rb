module SC2Parse
  class Replay
    module Parsers
      class ReplayDetails
        attr_reader :raw_data

        def initialize(data)
          @raw_data = SerialData.restore data
        end
      end
    end
  end
end
