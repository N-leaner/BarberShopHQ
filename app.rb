#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
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
	@c = Client.new
	erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do
	@c = Client.new params[:client]
	if @c.save
		@done = 'Спасибо, Вы записались'	
	else
		#@error = 'Ошибка записи - одно из полей не заполнено'
		@error = @c.errors.full_messages.first
	end	

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

get '/barber/:id' do	
	@barber = Barber.find(params["id"])
	erb :barber
end	

get '/bookings' do
	@clients = Client.order('created_at DESC')
  erb :bookings
end

get '/client/:id' do	
	@client = Client.find(params["id"])
	erb :client
end	