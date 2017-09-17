require 'data_mapper'
require 'dm-postgres-adapter'

require_relative './models/thermostat'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/thermostat_api_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
