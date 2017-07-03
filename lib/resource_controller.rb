require 'sinatra/base'
require './lib/resource'

class ResourceApp < Sinatra::Base

  get '/api/resources/' do
    [200, ResourceModel.all.to_json]
  end

  get '/api/resources/:id' do |id|
    begin
      resource = ResourceModel.get(Integer(id))
      unless resource.nil?
        [200, resource.to_json]
      else
        [404, "Record not found"]
      end
    rescue
      [403, "Bad format id, must be an integer"]
    end
  end
end
