require 'sinatra/base'
require 'json'
require_relative 'user'
require_relative 'class_type_error'


class UserBaseApp < Sinatra::Base

  @@user = UserModel

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
    raise ClassTypeError unless @@user <= UserModel
  end

  get '/api/users/' do
    [200, @@user.all.to_json]
  end

  get '/api/users/:id' do |id|
    begin
      user = @@user.get(Integer(id))
      unless user.nil?
        [200, user.to_json]
      else
        [204, "User not found"]
      end
    rescue
      [403, "Bad format id, must be an integer"]
    end
  end

  post '/api/users/' do
    data = JSON.load(request.body.read)
    user = @@user.new(data)
    if user.valid?
      user.save
      [201, 'User created']
    else
      [403, 'Bad format in data send']
    end
  end
  post '/api/users/:id' do |id|
    data = JSON.load(request.body.read)
    user = @@user.get(Integer(id))
    if user.update(data)
      [200, user.to_json]
    else
      [404, "Record not found"]
    end
  end

  delete '/api/users/:id' do |id|
    user = @@user.get(Integer(id))
    unless user.nil?
      user.destroy!
      [200, 'User deleted']
    else
      [404, 'Record not found']
    end
  end
end
