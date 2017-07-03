require 'data_mapper'

class ResourceModel
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :product_number, String
  property :created_at, DateTime
end
