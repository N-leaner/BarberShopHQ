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
	@color 		= params[:color].strip
	@date_visit = params[:date_].strip

	hh_ver = {:username => 'Не указано имя',
			:master => 'Не указан мастер',
			:date_ => 'Не указана дата'}
	@error = hh_ver.select {|key,_| params[key] == ''}.values.join(", ")		



	if @error == ''
		cl = Client.new
		cl.name = @user_name
		cl.phone = @user_phone
		cl.datestamp = @date_visit
		cl.color = @color
		cl.barber = @master
		cl.save
	end	

	erb :visit
end