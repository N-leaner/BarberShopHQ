#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base

end	

class Contact < ActiveRecord::Base

end	

get '/' do	
	@barbers = Barber.all
	erb :index
end

get '/visit'do
	@barbers = Barber.order 'name desc'
	erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do
	c = Client.new params[:client]
	c.save

	erb :visit
end

post '/contacts' do	
	@e_mail = params[:email].strip
	note = params[:text].strip
	
	hh_ver = {:email => 'Не указан e-mail',
			:text => 'Не набрано сообщение'}

	@error = hh_ver.select {|key,_| params[key] == ''}.values.join(", ")

	if @error == ''
		cont = Contact.new
		cont.email = @e_mail
		cont.note = note		
		cont.save

		@e_mail = ''
		@done = 'You entry save successfully!!'
	end

  erb :contacts
end