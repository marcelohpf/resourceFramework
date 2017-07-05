require 'sinatra/base'
require_relative 'role'
require_relative '../base/resources_base'
require_relative '../base/class_type_error'


class RoleBaseApp < Sinatra::Base
  include ResourcesBase

  def model
    RoleModel
  end

  ## The role module for Allocation framework
  # this class should handle te requests for basics operations
  # of CRUD (Create, Read, Update, Delete), and include a L of list elements
  #
  # To use the methods of this class only is necessary set in the header of
  # requisition the Content-type: application/json in roles
  # that upload some data
  #
  # Examples of use:
  #
  # Create:
	# curl -X POST http://localhost:9292/api/roles/ -d '{"name": "Papel", "description": "Descricao do papel", "group": "1"}' -H 'Content-type: application/json'
  #
  # Read:
  # curl -X GET http://localhost:9292/api/roles/
  # curl -X GET http://localhost:9292/api/roles/1
  #
  # Update:
	# curl -X POST http://localhost:9292/api/roles/1 -d '{"name": "PapelNovo", "description": "Descricao nova", "group": "2"}' -H 'Content-type: application/json'
  #
  # Delete:
  # curl -X DELETE http://localhost:9292/api/roles/1


  before do
    content_type :json
    raise ClassTypeError unless model() <= RoleModel
  end

  get '/api/roles/' do
    list
  end

  get '/api/roles/:id' do |id|
    retrieve(id)
  end

  post '/api/roles/' do
    create(request)
  end

  post '/api/roles/:id' do |id|
    update(id, request)
  end

  delete '/api/roles/:id' do |id|
    delete(id)
  end
end
