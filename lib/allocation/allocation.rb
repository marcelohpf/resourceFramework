require 'data_mapper'

class AllocationModel 
  include DataMapper::Resource 

  property :id, Serial
  property :description, String 
  timestamps :created_at, :updated_on

	belongs_to :user_model
	belongs_to :resource_model
end
