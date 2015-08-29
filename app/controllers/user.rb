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

  @login_info = params[:login]

  unless User.find_by_email(@login_info[:email]).nil?
    @user = User.find_by_email(@login_info[:email])
      if @login_info[:password] == @user.password 
        session[:user_id] = @user.id
        redirect '/userpage'
      end
      else
        redirect '/'
    end
  redirect '/'

end

get '/signup' do

  erb :signup

end

post '/signup' do

  @signup_info = params[:signup]

  if @signup_info[:password] == @signup_info[:confirm_pass]
    new_user = User.create(name: @signup_info[:name], email: @signup_info[:email], password: @signup_info[:password])
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
    @rentals = @user.bookings
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