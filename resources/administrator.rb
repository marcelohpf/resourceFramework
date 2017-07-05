require_relative '../lib/resources/resource'

class Administrator < UserModel
  property :password, String
end
