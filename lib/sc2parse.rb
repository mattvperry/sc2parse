require 'libmpq'

module SC2Parse
  autoload :BitStream, 'sc2parse/bitstream'
  autoload :SerialData, 'sc2parse/serial_data'
  autoload :Parsers, 'sc2parse/parsers'

  class Replay
    def initialize(path)
      begin
        @archive = MPQ::Archive.new path
      rescue LoadError
        raise LoadError, "Failed to load archive #{path.inspect}"
      end
      parse

      # Debugging
      require 'pp'
      pp @parsed_files["replay.details"].players
      pp @parsed_files["replay.details"].map_name
      pp @parsed_files
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
