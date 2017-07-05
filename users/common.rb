require_relative '../lib/authentication/user'

class Common < UserModel
  property :registration_date, Date
end