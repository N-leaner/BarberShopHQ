#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base

end

class Barber < ActiveRecord::Base

end	

get '/' do	
	@barbers = Barber.all
	erb :index
end

get '/visit'do
	@barbers = Barber.order 'name desc'
	erb :visit
end

post '/visit' do
	@barbers = Barber.order 'name desc'
	@master = params[:master]
	@user_name = params[:username].strip.capitalize
	@user_phone = params[:user_telephone].strip

	@error = ''
	if @user_name == ''
		@error = 'Enter a name!'		
	end
	if @user_phone == ''
		@error = 'Enter a phone!'		
	end	
	if !@error || @error.length == 0		
		cl = Client.new
		cl.name = @user_name
		cl.phone = @user_phone
		cl.save
	end	

	erb :visit
end