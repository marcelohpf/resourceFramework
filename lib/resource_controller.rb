require 'sinatra/base'
require './lib/resource'
require 'json'


class ResourceApp < Sinatra::Base

  ## The resource module for Allocation framework
  # this class should handle te requests for basics operations
  # of CRUD (Create, Read, Update, Delete), and include a L of list elements
  #
  # To use the methods of this class only is necessary set in the header of
  # requisition the Content-type: application/json in resources
  # that upload some data
  #
  # Examples of use:
  #
  # Create:
  # curl -X POST http://localhost:9292/api/resources/ -d '{"name": "coisa", "product_number": "feffex21"}' -H 'Content-type: application/json'
  #
  # Read:
  # curl -X GET http://localhost:9292/api/resources/
  # curl -X GET http://localhost:9292/api/resources/1
  #
  # Update:
  # curl -X POST http://localhost:9292/api/resources/8 -d '{"name": "coisa", "product_number": "000000"}' -H 'Content-type: application/json'
  #
  # Delete:
  # curl -X DELETE http://localhost:9292/api/resources/8


  before do
    content_type :json
  end

  get '/api/resources/' do
    [200, ResourceModel.all.to_json]
  end

  get '/api/resources/:id' do |id|
    begin
      resource = ResourceModel.get(Integer(id))
      unless resource.nil?
        [200, resource.to_json]
      else
        [204, "Record not found"]
      end
    rescue
      [403, "Bad format id, must be an integer"]
    end
  end

  post '/api/resources/' do
    data = JSON.load(request.body.read)
    resource = ResourceModel.new(data)
    if resource.valid?
      resource.save
      [201, 'Resource created']
    else
      [403, 'Bad format in data send']
    end
  end
  post '/api/resources/:id' do |id|
    data = JSON.load(request.body.read)
    resource = ResourceModel.get(Integer(id))
    if resource.update(data)
      [200, resource.to_json]
    else
      [404, "Record not found"]
    end
  end

  delete '/api/resources/:id' do |id|
    resource = ResourceModel.get(Integer(id))
    unless resource.nil?
      resource.destroy!
      [200, 'Record deleted']
    else
      [404, 'Record not found']
    end
  end
end
