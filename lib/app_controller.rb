require 'sinatra/base'

class BaseApp < Sinatra::Base
  get '/' do
    "This is the framework for resource allocation.\nVersion: 0.1"
  end
end
