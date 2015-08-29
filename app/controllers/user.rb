get '/' do
  @all_users = User.all
  @listings = Listing.all
  @tags = Tag.all
  erb :home

end

get '/error' do
  erb :error
end


post '/login' do
   @input = params[:login]
  
   unless @input.nil?
     @login = User.find_by_email(@input[:email])   
       if @input[:password] == @login.password  
       session[:user_id] = @login.id
       redirect '/userpage'
       else
       	redirect '/'
    end
    redirect '/error'
  end
end

get '/signup' do

  erb :signup

end

post '/signup' do

  @process = params[:signup]

  if @process[:password] == @process[:confirm_pass]
    new_user = User.create(
      name: @process[:name], 
      email: @process[:email], 
      password: @process[:password]
      )
    @user = User.find(new_user.id)
    session[:user_id] = @user.id
    redirect '/userpage'
  else
    redirect '/error'
  end

end

get '/userpage' do
  if session[:user_id] 
    @user = User.find(session[:user_id])

    @listings = @user.listings.all
    erb :userpage
  else
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end