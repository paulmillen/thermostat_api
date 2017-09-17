require 'data_mapper'
require 'dm-postgres-adapter'

class Thermostat

  include DataMapper::Resource

  property :id,           Serial
  property :api_key,      Text
  property :temperature,  Integer
  property :psm,          Boolean
  property :city,         Text

  def self.authenticate(api_key)
    user = first(api_key: api_key)
    user ? user : nil
  end

end
