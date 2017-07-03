require 'sinatra'

set :show_exceptions, false
set :dump_errors, false
set :run, false

configure :development do

  set :bind, '0.0.0.0'
  set :show_exceptions, true
  set :dump_errors, true

end
