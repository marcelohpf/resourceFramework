require 'sinatra/base'
require_relative '../resources/resource'
require_relative '../authentication/user'
require_relative '../base/resources_base'
require_relative '../base/class_type_error'


class AllocationBaseApp < Sinatra::Base
  include ResourcesBase

  ## The allocation module for Allocation framework
  # this class should handle te requests for basics operations
  # of CRUD (Create, Read, Update, Delete), and include a L of list elements
  #
  # To use the methods of this class only is necessary set in the header of
  # requisition the Content-type: application/json in allocations
  # that upload some data
  #
  # Examples of use:
  #
  # Create:
	# curl -X POST http://localhost:9292/api/allocations/ -d '{"name": "Papel", "description": "Descricao do papel", "group": "1"}' -H 'Content-type: application/json'
  #
  # Read:
  # curl -X GET http://localhost:9292/api/allocations/
  # curl -X GET http://localhost:9292/api/allocations/1
  #
  # Update:
	# curl -X POST http://localhost:9292/api/allocations/1 -d '{"name": "PapelNovo", "description": "Descricao nova", "group": "2"}' -H 'Content-type: application/json'
  #
  # Delete:
  # curl -X DELETE http://localhost:9292/api/allocations/1


  before do
    content_type :json
    raise ClassTypeError unless model() <= AllocationModel
  end

  get '/api/allocations/' do
    list
  end

  get '/api/allocations/:id' do |id|
    retrieve(id)
  end

  post '/api/allocations/' do
    create(request)
  end

  post '/api/allocations/:id' do |id|
    update(id, request)
  end

  delete '/api/allocations/:id' do |id|
    delete(id)
  end
end
