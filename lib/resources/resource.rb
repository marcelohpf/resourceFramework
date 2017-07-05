require 'data_mapper'

class ResourceModel
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :product_number, String
  timestamps :created_at, :updated_on
  property :type, Discriminator

	has n, :allocation_models
	has n, :role_models, through: Resource
end
