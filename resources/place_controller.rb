require 'sinatra/base'
require 'json'

require_relative 'resource'
require_relative '../lib/resources_base'

class PlaceApp < Sinatra::Base
  include ResourcesBase

  def model
    Place
  end

  get '/api/places/' do
    list
  end

  get '/api/places/:id' do |id|
    retrieve(id)
  end

  post '/api/places/' do
    create(request)
  end

  post '/api/places/:id' do |id|
    update(id, request)
  end

  delete '/api/places/:id' do |id|
    delete(id)
  end

end
