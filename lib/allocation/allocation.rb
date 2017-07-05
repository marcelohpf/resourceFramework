require 'data_mapper'

class AllocationModel 
  include DataMapper::Resource 

  property :id, Serial
  property :id_user, Integer 
  property :id_resource, Integer 
  property :description, String 
  timestamps :created_at, :updated_on
end
