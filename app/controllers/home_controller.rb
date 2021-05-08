class HomeController < ApplicationController

  before_action :authenticate_user!


  def new
    respond_to do |format|
      format.html {}
      format.js { render '/home/new.js.erb' }
    end
  end


  def index

    @weekdays = ["Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira"]
    @timetables = ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"]

    if params[:new_day].present? && ! params[:new_day].blank?
      @date = params[:new_day].to_date
    else
      @date = Time.current.strftime('%d/%m/%Y').to_date
    end

    if @date.monday?
      add = 0
    elsif @date.tuesday?
      add = 1
    elsif @date.wednesday?
      add = 2
    elsif @date.thursday?
      add = 3
    elsif @date.friday?
      add = 4
    elsif @date.saturday?
      @date = @date + 2.days
      add = 0
    elsif @date.sunday?
      @date = @date + 1.days
      add = 0
    end

    @iniDate = (@date - add.days)

    @dates = []
    i = 0
    @weekdays.each do |_day|
      @dates << (@iniDate + i.days).strftime('%d/%m/%Y')
      i += 1
    end

    @appointments = Booking.in_range(@date).order_by_date

  end

end
