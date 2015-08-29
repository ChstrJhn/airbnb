post '/listings/:id/booking' do
	@booking = params[:booking]
	@user = User.find(current_user.id)
	@listing = Listing.find(params[:id])
	@all_bookings = Booking.all
	if @all_bookings.find_by(start_date: @booking[:start_date]).nil?
		@user.bookings.create(start_date: @booking[:start_date], end_date: @booking[:end_date])
		redirect '/'
	else
		redirect "/listings/#{@listing.id}/book"
	end
end