module SC2Parse
  class Replay
    module Parsers
      autoload :ReplayDetails, 'sc2parse/parsers/replay_details.rb'
      autoload :ReplayInitdata, 'sc2parse/parsers/replay_initdata.rb'

      def self.parse(archive)
        parsed_files = {}
        archive.each_with_data do |name, data|
          parse_class = file_to_class name
          parsed_files[name] = parse_class.new data if parse_class
        end
        parsed_files
      end

      private
      def self.file_to_class(file)
        const = file.split('.').each { |f| f.capitalize! }.join('')
        return const_get(const) if const_defined?(const)
      end
    end
  end
end
