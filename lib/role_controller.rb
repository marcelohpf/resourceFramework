require 'sinatra/base'
require 'json'
require_relative 'role'
require_relative 'class_type_error'


class RoleBaseApp < Sinatra::Base

  @@role = RoleModel

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
	# curl -X POST http://localhost:9292/api/roles/ -d '{"name": "Papel"    , "description": "Descricao do papel", "group": "1"}' -H     'Content-type: application/json'
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
    raise ClassTypeError unless @@role <= RoleModel
  end

  get '/api/roles/' do
    [200, @@role.all.to_json]
  end

  get '/api/roles/:id' do |id|
    begin
      role = @@role.get(Integer(id))
      unless role.nil?
        [200, role.to_json]
      else
        [204, "Record not found"]
      end
    rescue
      [403, "Bad format id, must be an integer"]
    end
  end

  post '/api/roles/' do
    data = JSON.load(request.body.read)
    role = @@role.new(data)
    if role.valid?
      role.save
      [201, 'Role created']
    else
      [403, 'Bad format in data send']
    end
  end
  post '/api/roles/:id' do |id|
    data = JSON.load(request.body.read)
    role = @@role.get(Integer(id))
    if role.update(data)
      [200, role.to_json]
    else
      [404, "Record not found"]
    end
  end

  delete '/api/roles/:id' do |id|
    role = @@role.get(Integer(id))
    unless role.nil?
      role.destroy!
      [200, 'Record deleted']
    else
      [404, 'Record not found']
    end
  end
end
