require 'sinatra/base'

require_relative 'common'
require_relative '../lib/authentication/user_controller'


class CommonApp < UserBaseApp

  def model
   Common
  end

  get '/api/commons/' do
    list
  end

  get '/api/commons/:id' do |id|
    retrieve(id)
  end

  post '/api/commons/' do
    create(request)
  end

  post '/api/commons/:id' do |id|
    update(id, request)
  end

  delete '/api/commons/:id' do |id|
    delete(id)
  end

end
