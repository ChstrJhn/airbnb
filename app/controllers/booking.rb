post '/listings/:id/booking' do

	@booking = params[:booking]
	@user = User.find(current_user.id)
	@listing = Listing.find(params[:id])
	@all_bookings = Booking.all
	if @all_bookings.find_by(start_date: @booking[:start_date]).nil?
		@new_booking = @user.bookings.create(start_date: @booking[:start_date], end_date: @booking[:end_date])
		@listing.bookings << @new_booking
		@listing.booked = true
		@listing.booking_count += 1
		@listing.save
		redirect '/thank_you'
	else
		redirect "/listings/#{@listing.id}/book"
	end
end

post '/booking' do
  redirect '/'
end

get '/thank_you' do
	erb :thank_you
end