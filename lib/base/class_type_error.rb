class ClassTypeError < NameError
  def initialize(msg="The type class doesn't match with expected")
    super
  end
end
