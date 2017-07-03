require 'sinatra'
require 'data_mapper'
require 'require_all'

# Configure DataMapper Gem

DataMapper::setup(:default, "sqlite3://#{File.expand_path __dir__}/db.sqlite3")

require_all File.expand_path "#{__dir__}/lib"

DataMapper.finalize
DataMapper.repository.auto_upgrade!

# End DataMapper configuration

# Configure sinatra

set :show_exceptions, false
set :dump_errors, false
set :run, false

configure :development do

  set :bind, '0.0.0.0'
  set :show_exceptions, true
  set :dump_errors, true
  DataMapper::Logger.new($stdout, :debug)

end

# Run each controller application
# should include new controller using 
# use MyController
# run App
# reference: https://learn.co/lessons/sinatra-multiple-controllers
run ResourceApp
