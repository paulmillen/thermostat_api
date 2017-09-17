ENV["RACK_ENV"] ||= "development"

require 'json'
require 'sinatra/base'
require 'sinatra/cross_origin'

require_relative './data_mapper_setup'

class App < Sinatra::Base

  set :bind, '0.0.0.0'

  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  get '/thermostat' do
    p params.inspect
    user = Thermostat.authenticate(params[:api_key])
    data = { temperature: user.temperature, psm: user.psm, city: user.city }
    data.to_json
  end

  post '/thermostat' do
    user = Thermostat.authenticate(params[:api_key])
    p params
    user.temperature = params[:temperature]
    user.psm = params[:psm]
    user.city = params[:city]
    user.save
    DataMapper.auto_upgrade!
    p user.save
  end

  options '*' do
    response.headers["Allow"] = "GET, POST"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

run! if app_file == $0

end
