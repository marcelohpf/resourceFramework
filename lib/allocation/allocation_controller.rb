require 'sinatra/base'
require_relative 'allocation'
require_relative '../base/resources_base'
require_relative '../base/class_type_error'


class AllocationBaseApp < Sinatra::Base

	def model
		AllocationModel
	end

  before do
    content_type :json
  end

  get '/api/allocations/' do
    [200, AllocationModel.all.to_json]
  end

  get '/api/allocations/user/:id' do |id|
    [200, AllocationModel.all(user_model_id: id).to_json]
  end

	get '/api/allocations/resource/:id' do |id|
    [200, AllocationModel.all(resource_model_id: id).to_json]
  end

	get '/api/allocations/:id' do |id|
    [200, AllocationModel.get(id).to_json ]
  end

  post '/api/allocations/' do
		data = JSON.load(request.body.read)
		allocation = AllocationModel.new(data)
		if allocation.valid?
			allocation.save
			[201, 'Resource created']
		else
			[403, 'Bad format in data send']
		end
  end

  delete '/api/allocations/:id' do |id|
		AllocationModel.get(id).destroy!
    [202, "Record Delete"]
  end
end
