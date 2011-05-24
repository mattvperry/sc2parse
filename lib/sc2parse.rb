require 'libmpq'

module SC2Parse
  autoload :BitStream, 'sc2parse/bitstream'
  autoload :SerialData, 'sc2parse/serial_data'

  class Replay
    autoload :Parsers, 'sc2parse/parsers'

    def initialize(path)
      begin
        @archive = MPQ::Archive.new path
      rescue LoadError
        raise LoadError, "Failed to load archive #{path.inspect}"
      end
      parse
    end

    private
    def parse
      @parsed_files = Parsers.parse @archive
    end
  end
end

def sc2replay(file)
  SC2Parse::Replay.new file
end
