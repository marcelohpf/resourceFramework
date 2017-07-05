require 'sinatra/base'
require_relative 'allocation'
require_relative 'base_allocation'


class AllocationBaseApp < Sinatra::Base
	include AllocationBase

  get '/api/allocations/' do
  	allocations
  end

  get '/api/allocations/user/:id' do |id|
    get_user_allocations(id)
  end

	get '/api/allocations/resource/:id' do |id|
    get_resource_allocations(id)
  end

	get '/api/allocations/:id' do |id|
    allocation(id)
  end

  post '/api/allocations/' do
		allocate(request)
  end

  delete '/api/allocations/:id' do |id|
		deallocate(id)
  end
end
