require 'data_mapper'

class RoleModel 
  include DataMapper::Resource 

  property :id, Serial
  property :id_user, Integer 
  property :id_resource, Integer 
  timestamps :created_at, :updated_on
end
