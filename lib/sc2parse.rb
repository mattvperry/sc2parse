module SC2Parse
  autoload :BitStream, 'sc2parse/bitstream'
  autoload :SerialData, 'sc2parse/serial_data'
  autoload :Replay, 'sc2parse/replay'
end

def sc2replay(file)
  SC2Parse::Replay.new file
end
