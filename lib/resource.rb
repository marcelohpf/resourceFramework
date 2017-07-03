require 'data_mapper'

class ResourceModel
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :product_number, String
  timestamps :created_at, :updated_on
end
