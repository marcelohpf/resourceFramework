require 'sinatra/base'
require_relative 'user'
require_relative 'class_type_error'
require_relative 'resources_base'


class UserBaseApp < Sinatra::Base
  include ResourcesBase

  def model
    UserModel
  end

  ## The user module for Allocation framework
  # this class should handle te requests for basics operations
  # of CRUD (Create, Read, Update, Delete), and include a L of list elements
  #
  # To use the methods of this class only is necessary set in the header of
  # requisition the Content-type: application/json in users
  # that upload some data
  #
  # Examples of use:
  #
  # Create:
  # curl -X POST http://localhost:9292/api/users/ -d '{"name": "coisa", "register": "111111"}' -H 'Content-type: application/json'
  #
  # Read:
  # curl -X GET http://localhost:9292/api/users/
  # curl -X GET http://localhost:9292/api/users/1
  #
  # Update:
  # curl -X POST http://localhost:9292/api/users/8 -d '{"name": "coisa", "register": "000000"}' -H 'Content-type: application/json'
  #
  # Delete:
  # curl -X DELETE http://localhost:9292/api/users/8


  before do
    content_type :json
    raise ClassTypeError unless model <= UserModel
  end

  get '/api/users/' do
    list
  end

  get '/api/users/:id' do |id|
    retrieve(id)
  end

  post '/api/users/' do
    create(request)
  end

  post '/api/users/:id' do |id|
    update(id, request)
  end

  delete '/api/users/:id' do |id|
    delete(id)
  end

end
