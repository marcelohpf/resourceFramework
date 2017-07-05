require_relative '../lib/authentication/user'

class Administrator < UserModel
  property :password, String
end
