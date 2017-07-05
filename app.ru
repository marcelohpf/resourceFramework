require 'sinatra'

# Configure sinatra

require './sinatra_config'

# Configure DataMapper Gem

require './data_mapper'

# End DataMapper configuration

# Run each controller application
# should include new controller using 
# use MyController
# run App
# reference: https://learn.co/lessons/sinatra-multiple-controllers
use RoleBaseApp
use UserBaseApp
use AllocationBaseApp
use PlaceApp
use ItemApp
run BaseApp
