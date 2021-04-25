class BookingsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_booking, only: [:edit, :update, :destroy]


  def index
  	@bookings = Booking.all.order_by_date
  end

  def show

  end

  def new
    @booking = Booking.new
  end

  def edit

  end

  def create
  	@booking = Booking.new(params_booking)
    @booking.user = current_user

  	if @booking.save
  		redirect_to bookings_path, notice: "Reserva cadastrada com sucesso!"
  	else
  		render :new
  	end
  end

  def update
    @booking.current_user = current_user
    if @booking.update(params_booking)
    	redirect_to bookings_path, notice: "Reserva atualizada com sucesso!"
    else
    	render :edit
    end
  end

  def destroy
    @booking.current_user = current_user
    if @booking.destroy
      redirect_to bookings_path, notice: "A Reserva foi excluída com sucesso!"
    else
      render :index
    end
  end

  private
  def set_booking
    @booking = Booking.find(params[:id])
  end

  def params_booking
    params.require(:booking).permit(:description, :user_id, :hour, :date)
  end

end
