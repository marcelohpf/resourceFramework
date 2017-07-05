require 'sinatra/base'

require_relative 'resource'
require_relative '../lib/resources/resource_controller'


class ItemApp < ResourceBaseApp

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

	post '/api/items/:id/roles' do |id|
		add_resources_roles(id, request)
	end

	get '/api/items/:id/roles' do |id|
		resources_roles(id)
  end

end
