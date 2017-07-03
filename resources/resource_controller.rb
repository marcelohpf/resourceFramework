require 'sinatra/base'
require 'json'

require_relative 'resource'
require_relative '../lib/resource_controller'


class ResourceApp < ResourceBaseApp

  @@resource = Resource

end
