require 'sinatra/base'
require 'json'
require_relative 'class_type_error'


module ResourcesBase

  ## The resource class for Allocation framework
  # this module is the implementation to basic operations for a rest service
  # that implements a simple CRUD operations
  #
  # The module can be override to change the default behavior
  # The method model() : Class should be overrided to say for the application
  # wich is the model used and access the methods from DataMapper

  # This method is a abstract method, and return a ClassModel that includes 
  # DataMapper::Resource

  def model
    raise ClassTypeError
  end


  def list
    [200, model.all.to_json]
  end

  def retrieve(id)
    begin
      resource = model.get(Integer(id))
      unless resource.nil?
        [200, resource.to_json]
      else
        [404, "Record not found"]
      end
    rescue ArgumentError
      [403, "Bad format id, must be an integer"]
    end
  end

  def create(request)
    data = JSON.load(request.body.read)
    resource = model.new(data)
    if resource.valid?
      resource.save
      [201, 'Resource created']
    else
      [403, 'Bad format in data send']
    end
  end

  def update(id, request)
    begin
      data = JSON.load(request.body.read)
      resource = model.get(Integer(id))
      if resource.update(data)
        [200, resource.to_json]
      else
        [404, "Record not found"]
      end
    rescue ArgumentError
      [403, "Bad format id, must be an integer"]
    end
  end

  def delete(id)
    begin
      resource = model.get(Integer(id))
      unless resource.nil?
        resource.destroy!
        [200, 'Resource deleted']
      else
        [404, 'Record not found']
      end
    rescue ArgumentError
      [403, "Bad format id, must be an integer"]
    end
  end
end
