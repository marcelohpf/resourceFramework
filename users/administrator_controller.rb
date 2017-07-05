require 'sinatra/base'

require_relative 'administrator'
require_relative '../lib/authentication/user_controller'


class AdministratorApp < UserBaseApp

  def model
   Administrator 
  end

  get '/api/administrators/' do
    list
  end

  get '/api/administrators/:id' do |id|
    retrieve(id)
  end

  post '/api/administrators/' do
    create(request)
  end

  post '/api/administrators/:id' do |id|
    update(id, request)
  end

  delete '/api/administrators/:id' do |id|
    delete(id)
  end

end
