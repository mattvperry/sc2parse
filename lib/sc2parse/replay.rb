require 'libmpq'

module SC2Parse
  class Replay
    autoload :Details, 'sc2parse/replay/details'
    autoload :InitData, 'sc2parse/replay/init_data'
    autoload :Attributes, 'sc2parse/replay/attributes'

    def initialize(path)
      @archive = MPQ::Archive.new path
      parse_user_header
      parse_files

      require 'pp'
      pp self
    end

    private
    def parse_user_header
    end

    def parse_files
      @archive.each_with_data do |file, data|
        case file
        when 'replay.details'
          @details = Details.parse data
        when 'replay.initData'
          @initdata = InitData.parse data
        when 'replay.attributes.events'
          @attributes = Attributes.parse data
        end
      end
    end
  end
end
