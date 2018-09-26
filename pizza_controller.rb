require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('./models/pizza_order') #to require the whole models folder write it as ./models/*'

also_reload('..models/*') #this is so that we don't have to stop and start the web server (sinatra)

#index route, all the pizzas
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end

#new a pizza
#put full routes before partial routes with placeholders ie pizza_holder/new is a filepath, :id is placeholder.  if i had an option to search by name and id I would need to specifiy the filepath seperately for each ie pizza_orders/fine_by_name/:name and pizza_orders/find_by_id/:id
get '/pizza-orders/new' do

  erb(:new)
end

#show an individual order
get '/pizza-orders/:id' do

  @order = PizzaOrder.find(params[:id])
  erb(:show)
end

get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end
#i got this to work after a lot of looking about, I thought it would be OK as pizza-orders or pizza-orders/new but I had to cahnge it to something idfferent, not sur why.  need clarification.
post '/pizza-orders/save' do
  #as the class is initialized as a hash it just needs to have the inforamtion passed across we just pass the full hash
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

post '/pizza-orders/delete/:id' do
  @order = PizzaOrder.find(params[:id])

  @order.delete()
  erb(:delete)
end

post '/pizza-orders/:id' do
  @order = PizzaOrder.new(params)
#we are using the .new(params) because the params, including the id is being passed from the webserver.  At initialisation this creates the object, the object can then be used to update the database
  @order.update()
  erb(:update)
end
