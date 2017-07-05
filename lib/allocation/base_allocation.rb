require_relative 'allocation'
require_relative '../authentication/user'
require_relative '../resources/resource'

module AllocationBase

  def allocations
    [200, AllocationModel.all.to_json]
  end

  def get_user_allocations(id)
    user = UserModel.get(id)
    unless user.nil?
      [200, AllocationModel.all(user_model_id: id).to_json]
    else
      [404, "User not found"]
    end
  end


	def get_resource_allocations(id)
    resource = ResourceModel.get(id)
    unless resource.nil?
      [200, AllocationModel.all(resource_model_id: id).to_json]
    else
      [404, "Resource not found"]
    end
  end

	def allocation(id)
    allocation = AllocationModel.get(id)
    unless allocation.nil?
      [200, allocation.to_json ]
    else
      [404, "Allocation not exists"]
    end
  end

  def allocate(request)
    data = JSON.load(request.body.read)
    if check_avaibility(data)
  		allocation = AllocationModel.new(data)
  		if allocation.valid?
  			allocation.save
  			[201, 'Resource created']
  		else
  			[403, 'Bad format in data send']
  		end
    else
      [403, 'Resource or user not avaibale']
    end
  end

  def deallocate(id)
		allocation = AllocationModel.get(id)
    unless allocation.nil?
      [202, "Record Delete"]
    else
      [404, "Allocation doesn't exists"]
    end
  end

  def check_avaibility(data)
    ## TODO: Implement the avaibility
    true
  end
end
