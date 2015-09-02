post '/listings/user' do 
    @details = params[:new]
    @tags = params[:tag]
    arr = []
    @user = User.find_by_id(session[:user_id])
    @new_listing = @user.listings.create(@details)
    arr = @tags.split
    arr.map! {|category| category.gsub(",","")}
    arr.each do |tag|
    	@tags = Tag.find_or_create_by(category: tag)
      @new_listing.tags << @tags
      end
    redirect '/userpage'
end


get'/listings/:id' do
  @categories_arr = []
  @listing = Listing.find(params[:id])
  @list_categories = @listing.tags
  @list_categories.each do |name|
    @categories_arr << name.category
  end
erb :listing
end

delete '/listings/:id/delete' do
  @listing= Listing.find(params[:id])
  @listing.destroy

  redirect '/userpage'
end

get '/listings/:id/edit' do
  @listing = Listing.find(params[:id])
  erb :edit
end

post '/listings/:id/edit' do

  @details = params[:edit]
  @listing = Listing.find_by_id(params[:id])
  @listing.update(@details)
  redirect "/listings/#{@listing.id}"
end

get '/listings/:id/book' do
  @listings = Listing.all
  @tags = Tag.all
  all_users = User.all
  @categories_arr = []
  @listing = Listing.find(params[:id])
  @list_categories = @listing.tags

  @list_categories.each do |name|
    @categories_arr << name.category
  end

  if current_user.id != @listing.user.id
    @listing = Listing.find_by_id(params[:id])
    erb :book
  else 
    erb :listing
  end

end


get '/tags/:category' do

  @tag = Tag.find_by(category: params[:category])
  @listings_by_tag = @tag.listings
  erb :listings_by_tag
end
