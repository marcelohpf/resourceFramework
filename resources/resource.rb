require_relative '../lib/resource'

class Resource < ResourceModel
  property :manutention, Boolean
end

class Item < Resource
  property :date_acquisition, Date
end

class Place < Resource
  property :area, Decimal

end
