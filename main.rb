    
require 'sinatra'
# require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'

require_relative 'models/cake_type'
require_relative 'models/cake'
require_relative 'models/customer'
require_relative 'models/order'

enable  :sessions

helpers do

  def current_user
    Customer.find_by(id: session[:customer_id])
  end 

  def logged_in? 
    !!current_user
  end
end

after do 
  ActiveRecord::Base.connection.close
end 

get '/' do
  @cake_types = CakeType.all
  erb :index
end

get '/mystory' do
  @cake_types = CakeType.all
  erb :mystory
end

get '/login' do
  @cake_types = CakeType.all
  erb :login
end

get '/logout' do
  session[:customer_id] = nil
  redirect '/login'
end

get '/track_order' do
  @cake_types = CakeType.all

  if logged_in?
    @customer = Customer.find_by(id: session[:customer_id])
    @order = Order.find_by(customer_id: session[:customer_id])
    @cake = Cake.find_by(id: @order.cake_id)
    erb :track_order
  else
    erb :login    
  end
end  

get '/contact' do
  @cake_types = CakeType.all
  erb :contact
end

# get '/:cake_type' do
get '/cakes/:cake_type' do
  @cake_types = CakeType.all
  @cakes = Cake.where(cake_type: params[:cake_type])
  erb :cake_type
end

get '/cakes/:cake_type/:title' do
  @cake_types = CakeType.all
  @cake = Cake.find_by(title: params[:title])
  if logged_in?
    @customer = Customer.find_by(id: session[:customer_id])
  end

  erb :new_order
end

post '/cakes/:cake_type/:title/order' do
  @cake_types = CakeType.all
  @cake = Cake.find_by(title: params[:title])
  
  @customer_name = params[:customer_name]
  @customer_email = params[:email]
  @pickup_date = params[:pickup_date]
  @password = params[:password]
  @quantity = params[:quantity]
  
  customer = Customer.find_by(email: @customer_email)

  if !customer
    customer = Customer.new
    customer.name = @customer_name
    customer.email = @customer_email
  
    # if @password == ""
    #   @password = "cheese" # Password cannot be empty
    # end
  
    customer.password = @password
    customer.save
  end

  @order = Order.new
  @order.cake_id = @cake.id 
  @order.customer_id = customer.id
  @order.total_price = @cake.price * @quantity.to_i
  @order.quantity = @quantity 
  @order.pickup_date = @pickup_date 
  @order.save
  
  erb :confirm_order
end

# post '/:cake_type/:title/order/confirm_and_pay' do
#   @cake_types = CakeType.all
#   @cake = Cake.find_by(title: params[:title])
#   erb :pay
# end


post '/authenticate' do
  @cake_types = CakeType.all
  customer = Customer.find_by(email: params[:email]) 
  
  if customer && customer.authenticate(params[:password])
    session[:customer_id] = customer.id
    redirect '/track_order'
  else  
    erb :login
  end
end
