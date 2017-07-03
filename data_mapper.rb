require 'data_mapper'
require 'require_all'
# Configure DataMapper Gem
if not ENV['RACK_ENV'].nil? and ENV['RACK_ENV'].match? '^development$'
  DataMapper::Logger.new($stdout, :debug)
end

DataMapper::setup(:default, "sqlite3://#{File.expand_path __dir__}/db.sqlite3")

require_all File.expand_path "#{__dir__}/lib"
require_all File.expand_path "#{__dir__}/resources"

DataMapper.finalize
DataMapper.repository.auto_upgrade!
