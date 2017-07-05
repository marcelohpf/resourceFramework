require 'data_mapper'

class RoleModel 
  include DataMapper::Resource 

  property :id, Serial
  property :name, String
	property :description, String
	property :group, Integer
  timestamps :created_at, :updated_on
end
