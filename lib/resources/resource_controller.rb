require 'sinatra/base'
require 'json'
require_relative 'resource'
require_relative '../base/resources_base'
require_relative '../base/class_type_error'


class ResourceBaseApp < Sinatra::Base
  include ResourcesBase

  def model
    ResourceModel
  end

  ## The role module for Allocation framework
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
	# curl -X POST http://localhost:9292/api/resources/ -d '{"name": "Papel", "product_number": "ff2feef3"}' -H     'Content-type: application/json'
  #
  # Read:
  # curl -X GET http://localhost:9292/api/resources/
  # curl -X GET http://localhost:9292/api/resources/1
  #
  # Update:
	# curl -X POST http://localhost:9292/api/resources/1 -d '{"name": "PapelNovo", "product_number": "ff2feef3"}' -H 'Content-type: application/json'
  #
  # Delete:
  # curl -X DELETE http://localhost:9292/api/resources/1


  before do
    content_type :json
    raise ClassTypeError unless model() <= ResourceModel
  end

  get '/api/resources/' do
    list
  end

  get '/api/resources/:id' do |id|
    retrieve(id)
  end

  post '/api/resources/' do
    create(request)
  end

  post '/api/resources/:id' do |id|
    update(id, request)
  end

	post '/api/resources/:id/roles' do |id|
		add_resources_roles(id, request)
	end

	get '/api/resources/:id/roles' do |id|
		resources_roles(id)
  end

  delete '/api/resources/:id' do |id|
    delete(id)
  end

  def resources_roles(id)
		resource = ResourceModel.get(id)
		unless resource.nil?
      [200, resource.role_models.map{|x| [x.id,x.name]}.to_json]
    else
			[404, "Not found"]
		end
  end

  def add_resources_roles(id, request)
    data = JSON.load(request.body.read)
		resource = ResourceModel.get(id)
		data.each do |role|
			ResourceModelRoleModel.create(resource_model: resource, role_model_id: role)
    end
		[200, "Add role to resources"]
  end

end
