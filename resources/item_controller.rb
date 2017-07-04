require 'sinatra/base'

require_relative 'resource'
require_relative '../lib/resources_base'


class ItemApp < Sinatra::Base
  include ResourcesBase

  def model
    Item
  end

  get '/api/items/' do
    list
  end

  get '/api/items/:id' do |id|
    retrieve(id)
  end

  post '/api/items/' do
    create(request)
  end

  post '/api/items/:id' do |id|
    update(id, request)
  end

  delete '/api/items/:id' do |id|
    delete(id)
  end

end
