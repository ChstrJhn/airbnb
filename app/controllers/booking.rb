post '/listings/:id/booking' do
	@booking = params[:booking]
	@listing = Listing.find(params[:id])
	@listing
	@all_bookings = Booking.all
	if @all_bookings.find_by(start_date: @booking[:start_date]).nil?
		new_booking = Booking.create(start_date: @booking[:start_date], end_date: @booking[:end_date])
		redirect '/'
	else
		redirect '/listings/#{@listing.id}/book'
	end
end