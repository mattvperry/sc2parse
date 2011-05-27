module SC2Parse
  class Replay
    module InitData
      def self.parse(data)
        stream = BitStream.new data
        struct = {}
        struct[:player_names] = []
        stream.read_small_int.times do
          name_length = stream.read_small_int
          struct[:player_names] << stream.read_string(name_length)
          stream.skip 5 # 5 nulls after each name
        end
        struct[:player_names].delete_if { |x| x == '' }

        stream.skip 24 # Unknown field
        id_length = stream.read_small_int
        struct[:sc_account_id] = stream.read_string(id_length)
        stream.skip 684 # Unknown data
        struct[:realms], struct[:map_hashes] = [], []
        while stream.read_string(4).downcase == 's2ma'
          stream.skip 2 # Unknown data
          struct[:realms] << stream.read_string(2).downcase
          struct[:map_hashes] << stream.read_format(32, 'L!')
        end
        struct
      end
    end
  end
end
