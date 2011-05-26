require 'libmpq'

module SC2Parse
  autoload :Details, 'sc2parse/replay/details'
  autoload :InitData, 'sc2parse/replay/init_data'

  class Replay
    def initialize(path)
      begin
        @archive = MPQ::Archive.new path
      rescue LoadError
        raise LoadError, "Failed to load archive #{path.inspect}"
      end
    end
  end
end
