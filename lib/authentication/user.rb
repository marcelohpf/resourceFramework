require 'data_mapper'

class UserModel
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :register, String
  timestamps :created_at, :updated_on

	has n, :allocation_models
	belongs_to :role_model
end
