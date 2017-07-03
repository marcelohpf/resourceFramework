require 'sinatra'
require 'data_mapper'
require 'require_all'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db.sqlite3")

DataMapper.finalize

require_all 'lib/models'

DataMapper.repository.auto_migrate!
